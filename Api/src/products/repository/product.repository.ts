import { Inject, Injectable } from '@nestjs/common';
import { IProductRepository } from '../interfaces/product-repository.interface';
import { BaseProduct } from '../entities/base-product.entity';
import { Knex } from 'knex';

@Injectable()
export class ProductRepository implements IProductRepository {
  constructor(@Inject('KNEX_CONNECTION') private readonly knex: Knex) {}

  async findAll(): Promise<BaseProduct[]> {
    return await this.knex<BaseProduct>('products')
      .select('*')
      .orderBy('id', 'asc');
  }

  async findMany(limit: number): Promise<BaseProduct[]> {
    const l = Number(limit) > 0 ? Math.floor(Number(limit)) : 10;
    return await this.knex<BaseProduct>('products')
      .select('*')
      .orderBy('id', 'asc')
      .limit(l);
  }
  // Aquí irían los métodos para interactuar con la base de datos
}
