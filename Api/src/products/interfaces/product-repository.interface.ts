import { BaseProduct } from '../entities/base-product.entity';

export interface IProductRepository {
  findAll(): Promise<BaseProduct[]>;
  findMany(limit: number): Promise<BaseProduct[]>;
}
