import type {
	BucketLocationConstraint,
	S3Client as S3ClientType,
} from "@aws-sdk/client-s3";

import { isPublicBucket, type StorageBucket } from "../constants";
import { StorageError } from "../error";

// Lazy-load AWS SDK to reduce cold start time
// The AWS SDK is very heavy and can cause Cloudflare Workers to exceed CPU time limits during startup
let _s3ClientModule: typeof import("@aws-sdk/client-s3") | null = null;
let _s3PresignerModule: typeof import("@aws-sdk/s3-request-presigner") | null =
	null;

async function getS3ClientModule() {
	if (!_s3ClientModule) {
		_s3ClientModule = await import("@aws-sdk/client-s3");
	}
	return _s3ClientModule;
}

async function getS3PresignerModule() {
	if (!_s3PresignerModule) {
		_s3PresignerModule = await import("@aws-sdk/s3-request-presigner");
	}
	return _s3PresignerModule;
}

interface StorageBaseOptions {
	bucket: StorageBucket;
	key: string;
}

interface UploadOptions extends StorageBaseOptions {
	file: File;
	userId?: string;
	isPublic?: boolean;
}

interface GetPresignedUrl extends StorageBaseOptions {
	expiresIn?: number;
}

export interface StorageService {
	ensureBucket(bucket: StorageBucket): Promise<void>;
	upload(options: UploadOptions): Promise<string>;
	delete(options: StorageBaseOptions): Promise<void>;
	getPresignedUrl(options: GetPresignedUrl): Promise<string>;
	getPublicUrl(options: StorageBaseOptions): string;
}

interface S3StorageOptions {
	endpoint: string;
	region: string;
	accessKeyId: string;
	secretAccessKey: string;
	publicUrl: string;
}

export class S3StorageService implements StorageService {
	#client: S3ClientType | null = null;
	readonly #options: S3StorageOptions;
	readonly #publicUrl: string;
	readonly #bucketExists = new Map<StorageBucket, boolean>();
	readonly #bucketCreationPromises = new Map<StorageBucket, Promise<void>>();

	static readonly DEFAULT_PRESIGNED_URL_EXPIRY = 900; // 15 minutes
	static readonly ONE_DAY_PRESIGNED_URL_EXPIRY = 86400; // 1 day
	static readonly SEVEN_DAY_PRESIGNED_URL_EXPIRY = 604800; // 7 days

	constructor(options: S3StorageOptions) {
		this.#options = options;
		this.#publicUrl = options.publicUrl;
	}

	async #getClient(): Promise<S3ClientType> {
		if (!this.#client) {
			const { S3Client } = await getS3ClientModule();
			this.#client = new S3Client({
				endpoint: this.#options.endpoint,
				region: this.#options.region,
				credentials: {
					accessKeyId: this.#options.accessKeyId,
					secretAccessKey: this.#options.secretAccessKey,
				},
				forcePathStyle: true,
			});
		}
		return this.#client;
	}

	async ensureBucket(bucket: StorageBucket): Promise<void> {
		if (this.#bucketExists.get(bucket)) return;

		const existingPromise = this.#bucketCreationPromises.get(bucket);
		if (existingPromise) return existingPromise;

		const promise = this.#createBucketIfNeeded(bucket);
		this.#bucketCreationPromises.set(bucket, promise);

		try {
			await promise;
			if (isPublicBucket(bucket)) {
				await this.#setPublicBucketPolicy(bucket);
			}
		} finally {
			this.#bucketCreationPromises.delete(bucket);
		}
	}

	async #createBucketIfNeeded(bucket: StorageBucket): Promise<void> {
		const client = await this.#getClient();
		const { HeadBucketCommand } = await getS3ClientModule();

		try {
			await client.send(new HeadBucketCommand({ Bucket: bucket }));
			this.#bucketExists.set(bucket, true);
			console.debug("[S3StorageService] Bucket already exists", { bucket });
		} catch (error) {
			if (this.#isNotFoundError(error)) {
				await this.#createBucket(bucket);
			} else {
				throw this.#wrapError(error, "Failed to check bucket existence");
			}
		}
	}

	async #createBucket(bucket: StorageBucket): Promise<void> {
		const client = await this.#getClient();
		const { CreateBucketCommand } = await getS3ClientModule();

		try {
			await client.send(
				new CreateBucketCommand({
					Bucket: bucket,
					CreateBucketConfiguration: {
						LocationConstraint: this.#options
							.region as BucketLocationConstraint,
					},
				}),
			);

			// Wait for bucket to become available (eventual consistency)
			await this.#waitForBucket(bucket);

			// Configure public access policy for public buckets
			if (isPublicBucket(bucket)) {
				await this.#setPublicBucketPolicy(bucket);
			}

			this.#bucketExists.set(bucket, true);
			console.info("[S3StorageService] Bucket created successfully", {
				bucket,
				isPublic: isPublicBucket(bucket),
			});
		} catch (error) {
			throw this.#wrapError(error, "Failed to create bucket");
		}
	}

	async #waitForBucket(
		bucket: StorageBucket,
		maxRetries = 5,
		delayMs = 500,
	): Promise<void> {
		const client = await this.#getClient();
		const { HeadBucketCommand } = await getS3ClientModule();

		for (let i = 0; i < maxRetries; i++) {
			try {
				await client.send(new HeadBucketCommand({ Bucket: bucket }));
				return;
			} catch (error) {
				if (i === maxRetries - 1) {
					throw error;
				}
				console.debug(
					`[S3StorageService] Waiting for bucket to become available (attempt ${i + 1}/${maxRetries})`,
					{ bucket },
				);
				await new Promise((resolve) => setTimeout(resolve, delayMs));
			}
		}
	}

	/**
	 * Sets a public read policy on a bucket for anonymous access
	 * This allows objects in the bucket to be accessed via direct URL
	 */
	async #setPublicBucketPolicy(
		bucket: StorageBucket,
		maxRetries = 5,
		delayMs = 500,
	): Promise<void> {
		const client = await this.#getClient();
		const { DeletePublicAccessBlockCommand, PutBucketPolicyCommand } =
			await getS3ClientModule();

		const policy = {
			Version: "2012-10-17",
			Statement: [
				{
					Sid: "PublicReadGetObject",
					Effect: "Allow",
					Principal: "*",
					Action: ["s3:GetObject"],
					Resource: [`arn:aws:s3:::${bucket}/*`],
				},
			],
		};

		for (let attempt = 0; attempt < maxRetries; attempt++) {
			try {
				// First, remove public access block (required for MinIO/S3)
				await client.send(
					new DeletePublicAccessBlockCommand({ Bucket: bucket }),
				);

				await client.send(
					new PutBucketPolicyCommand({
						Bucket: bucket,
						Policy: JSON.stringify(policy),
					}),
				);

				console.info("[S3StorageService] Public policy set for bucket", {
					bucket,
				});
				return;
			} catch (error) {
				const isNoSuchBucket =
					(error as { Code?: string })?.Code === "NoSuchBucket";

				if (isNoSuchBucket && attempt < maxRetries - 1) {
					console.debug(
						`[S3StorageService] Bucket not ready for policy, retrying (attempt ${attempt + 1}/${maxRetries})`,
						{ bucket },
					);
					await new Promise((resolve) => setTimeout(resolve, delayMs));
					continue;
				}

				// Log but don't fail - bucket is created, policy can be set manually
				console.warn(
					"[S3StorageService] Failed to set public policy, bucket created without public access",
					{ bucket, error },
				);
				return;
			}
		}
	}

	async upload(options: UploadOptions): Promise<string> {
		const { file, bucket, key, userId, isPublic = false } = options;
		const client = await this.#getClient();
		const { PutObjectCommand } = await getS3ClientModule();

		try {
			await this.ensureBucket(bucket);

			const body = new Uint8Array(await file.arrayBuffer());

			await client.send(
				new PutObjectCommand({
					Bucket: bucket,
					Key: key,
					Body: body,
					ContentType: file.type,
					...(userId && { Metadata: { uid: userId } }),
					...(isPublic && { ACL: "public-read" }),
				}),
			);

			return this.getPublicUrl({ bucket, key });
		} catch (error) {
			throw this.#wrapError(error, "Failed to upload file");
		}
	}

	async delete(options: StorageBaseOptions): Promise<void> {
		const client = await this.#getClient();
		const { DeleteObjectCommand } = await getS3ClientModule();

		try {
			await client.send(
				new DeleteObjectCommand({
					Bucket: options.bucket,
					Key: options.key,
				}),
			);
		} catch (error) {
			if (this.#isNotFoundError(error)) return;
			throw this.#wrapError(error, "Failed to delete file");
		}
	}

	async getPresignedUrl(options: GetPresignedUrl): Promise<string> {
		const client = await this.#getClient();
		const { GetObjectCommand } = await getS3ClientModule();
		const { getSignedUrl } = await getS3PresignerModule();

		try {
			await this.ensureBucket(options.bucket);

			const command = new GetObjectCommand({
				Bucket: options.bucket,
				Key: options.key,
			});

			return await getSignedUrl(client, command, {
				expiresIn:
					options.expiresIn ?? S3StorageService.DEFAULT_PRESIGNED_URL_EXPIRY,
			});
		} catch (error) {
			throw this.#wrapError(error, "Failed to generate presigned URL");
		}
	}

	getPublicUrl({ bucket, key }: StorageBaseOptions): string {
		return `${this.#publicUrl}/${bucket}/${key}`;
	}

	#isNotFoundError(error: unknown): boolean {
		return (
			(error as { $metadata?: { httpStatusCode: number } }).$metadata
				?.httpStatusCode === 404
		);
	}

	#wrapError(error: unknown, defaultMessage: string) {
		console.error(`[S3StorageService] ${defaultMessage}`, { error });
		return new StorageError(
			error instanceof Error ? error.message : defaultMessage,
		);
	}
}
