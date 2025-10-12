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
	#client: S3Client;
	private publicUrl: string;

	private _bucketExists: Record<StorageBucket, boolean> = {
		driver: false,
		merchant: false,
		user: false,
	};

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
		this.publicUrl = options.publicUrl;
	}

	async ensureBucket(bucket: StorageBucket): Promise<void> {
		if (this._bucketExists[bucket]) return;

		try {
			await this.#client.send(new HeadBucketCommand({ Bucket: bucket }));
			this._bucketExists[bucket] = true;
			log.info(`Bucket ${bucket} already exists.`);
		} catch (error) {
			if ((error as any).$metadata?.httpStatusCode === 404) {
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
					this._bucketExists[bucket] = true;
					log.info(`Bucket ${bucket} created successfully.`);
				} catch (createError) {
					log.error(createError);
					throw new StorageError(
						createError instanceof Error
							? createError.message
							: "Failed to create bucket",
					);
				}
			} else {
				log.error(error);
				throw new StorageError(
					error instanceof Error
						? error.message
						: "Failed to check bucket existence",
				);
			}
		}
	}

	async upload(options: UploadOptions): Promise<string> {
		try {
			await this.ensureBucket(options.bucket);
			const { file, bucket, key } = options;

			const arrayBuffer = await file.arrayBuffer();
			const body = new Uint8Array(arrayBuffer);

			const command = new PutObjectCommand({
				Bucket: bucket,
				Key: key,
				Body: body,
				ContentType: file.type,
				Metadata: options.userId ? { uid: options.userId } : undefined,
			});

			await this.#client.send(command);
			return this.getPublicUrl({ bucket, key });
		} catch (error) {
			log.error(error);
			throw new StorageError(
				error instanceof Error ? error.message : "Failed to upload file",
			);
		}
	}

	async delete(options: StorageBaseOptions): Promise<void> {
		try {
			const command = new DeleteObjectCommand({
				Bucket: options.bucket,
				Key: options.key,
			});
			await this.#client.send(command);
		} catch (error) {
			log.error(error);
			throw new StorageError(
				error instanceof Error ? error.message : "Failed to delete file",
			);
		}
	}

	async getPresignedUrl(options: GetPresignedUrl): Promise<string> {
		try {
			await this.ensureBucket(options.bucket);

			const command = new GetObjectCommand({
				Bucket: options.bucket,
				Key: options.key,
			});

			const url = await getSignedUrl(this.#client, command, {
				expiresIn: options.expiresIn ?? 900,
			});
			return url;
		} catch (error) {
			log.error(error);
			throw new StorageError(
				error instanceof Error
					? error.message
					: "Failed to generate presigned URL",
			);
		}
	}

	getPublicUrl(options: StorageBaseOptions): string {
		return `${this.publicUrl}/${options.bucket}/${options.key}`;
	}
}
