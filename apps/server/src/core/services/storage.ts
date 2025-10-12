import {
	type BucketLocationConstraint,
	CreateBucketCommand,
	DeleteObjectCommand,
	GetObjectCommand,
	HeadBucketCommand,
	PutObjectCommand,
	S3Client,
} from "@aws-sdk/client-s3";
import { getSignedUrl } from "@aws-sdk/s3-request-presigner";
import { log } from "@/core/logger";
import type { StorageBucket } from "../constants";
import { StorageError } from "../error";

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
	readonly #client: S3Client;
	readonly #publicUrl: string;
	readonly #bucketExists = new Map<StorageBucket, boolean>();
	readonly #bucketCreationPromises = new Map<StorageBucket, Promise<void>>();

	private static readonly DEFAULT_PRESIGNED_URL_EXPIRY = 900; // 15 minutes

	constructor(options: S3StorageOptions) {
		this.#client = new S3Client({
			endpoint: options.endpoint,
			region: options.region,
			credentials: {
				accessKeyId: options.accessKeyId,
				secretAccessKey: options.secretAccessKey,
			},
			forcePathStyle: true,
		});
		this.#publicUrl = options.publicUrl;
	}

	async ensureBucket(bucket: StorageBucket): Promise<void> {
		if (this.#bucketExists.get(bucket)) return;

		const existingPromise = this.#bucketCreationPromises.get(bucket);
		if (existingPromise) return existingPromise;

		const promise = this.#createBucketIfNeeded(bucket);
		this.#bucketCreationPromises.set(bucket, promise);

		try {
			await promise;
		} finally {
			this.#bucketCreationPromises.delete(bucket);
		}
	}

	async #createBucketIfNeeded(bucket: StorageBucket): Promise<void> {
		try {
			await this.#client.send(new HeadBucketCommand({ Bucket: bucket }));
			this.#bucketExists.set(bucket, true);
			log.info(`Bucket ${bucket} already exists.`);
		} catch (error) {
			if (this.#isNotFoundError(error)) {
				await this.#createBucket(bucket);
			} else {
				throw this.#wrapError(error, "Failed to check bucket existence");
			}
		}
	}

	async #createBucket(bucket: StorageBucket): Promise<void> {
		try {
			await this.#client.send(
				new CreateBucketCommand({
					Bucket: bucket,
					CreateBucketConfiguration: {
						LocationConstraint: this.#client.config
							.region as BucketLocationConstraint,
					},
				}),
			);

			this.#bucketExists.set(bucket, true);
			log.info(`Bucket ${bucket} created successfully.`);
		} catch (error) {
			throw this.#wrapError(error, "Failed to create bucket");
		}
	}

	async upload(options: UploadOptions): Promise<string> {
		const { file, bucket, key, userId, isPublic = false } = options;

		try {
			await this.ensureBucket(bucket);

			const body = new Uint8Array(await file.arrayBuffer());

			await this.#client.send(
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
		try {
			await this.#client.send(
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
		try {
			await this.ensureBucket(options.bucket);

			const command = new GetObjectCommand({
				Bucket: options.bucket,
				Key: options.key,
			});

			return await getSignedUrl(this.#client, command, {
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
		log.error(error);
		return new StorageError(
			error instanceof Error ? error.message : defaultMessage,
		);
	}
}
