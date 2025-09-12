import {
	CreateBucketCommand,
	HeadBucketCommand,
	PutObjectCommand,
	S3Client,
} from "@aws-sdk/client-s3";
import { StorageError } from "../error";

interface StorageBaseOptions {
	bucket: string;
	key: string;
}

interface UploadOptions extends StorageBaseOptions {
	file: File;
	userId?: string;
}

export interface StorageService {
	ensureBucket(bucket: string): Promise<void>;
	upload(options: UploadOptions): Promise<string>;
	delete(options: StorageBaseOptions): Promise<void>;
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
	private s3Client: S3Client;
	private publicUrl: string;

	constructor(options: S3StorageOptions) {
		this.s3Client = new S3Client({
			endpoint: options.endpoint,
			region: options.region,
			credentials: {
				accessKeyId: options.accessKeyId,
				secretAccessKey: options.secretAccessKey,
			},
		});
		this.publicUrl = options.publicUrl;
	}

	async ensureBucket(bucket: string): Promise<void> {
		try {
			await this.s3Client.send(new HeadBucketCommand({ Bucket: bucket }));
		} catch (error) {
			if (error instanceof Error && error.name === "NotFound") {
				await this.s3Client.send(new CreateBucketCommand({ Bucket: bucket }));
			} else {
				throw new StorageError(`Failed to ensure bucket "${bucket}" exists`, {
					prevError: error instanceof Error ? error : undefined,
				});
			}
		}
	}

	async upload(options: UploadOptions): Promise<string> {
		await this.ensureBucket(options.bucket);
		const { file, bucket, key } = options;
		const command = new PutObjectCommand({
			Bucket: bucket,
			Key: key,
			Body: file.stream(),
			ContentType: file.type,
			Metadata: options.userId ? { uid: options.userId } : undefined,
		});
		await this.s3Client.send(command);
		return this.getPublicUrl({ bucket, key });
	}

	async delete(options: StorageBaseOptions): Promise<void> {
		const { DeleteObjectCommand } = await import("@aws-sdk/client-s3");
		const command = new DeleteObjectCommand({
			Bucket: options.bucket,
			Key: options.key,
		});
		await this.s3Client.send(command);
	}

	getPublicUrl(options: StorageBaseOptions): string {
		return `${this.publicUrl}/${options.bucket}/${options.key}`;
	}
}
