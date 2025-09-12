export interface Location {
	latitude: number;
	longitude: number;
}

export interface BaseRepository<T> {
	getById(id: string): Promise<T | null>;
	create(item: T): Promise<T>;
	update(id: string, item: Partial<T>): Promise<T>;
	delete(id: string): Promise<void>;
}
