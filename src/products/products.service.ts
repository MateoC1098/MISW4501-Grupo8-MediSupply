import { Inject, Injectable } from '@nestjs/common';
import { Consumable } from './entities/consumable.entity';
import { Pharmaceutical } from './entities/pharmaceutical.entity';
import { BaseProduct } from './entities/base-product.entity';
import { CACHE_MANAGER } from '@nestjs/cache-manager';
import type { Cache } from 'cache-manager';
import { Knex } from 'knex';
import { IProductRepository } from './interfaces/product-repository.interface';

@Injectable()
export class ProductsService {
  constructor(
    @Inject(CACHE_MANAGER) private cache: Cache,
    @Inject('IProductRepository')
    private productRepository: IProductRepository,
    @Inject('KNEX_CONNECTION') private readonly knex: Knex
  ) {}

  async getAllProductsUsingCache(limit:number): Promise<BaseProduct[]> {
    const cacheKey = `products:all:${limit}`;
    const cached = await this.cache.get<BaseProduct[]>(cacheKey);

    if (cached) {
      console.log('📦 getAllProducts → from cache');
      return cached;
    }

    console.log('💾 getAllProducts → from DB');
    const products = await this.productRepository.findMany(limit);

    await (this.cache as any).set(cacheKey, products, { ttl: 60*5 }); // cache 5 min
    return products;
  }

  async getAllProductsWithOutCache(limit:number): Promise<BaseProduct[]> {
    return this.productRepository.findMany(limit);
  }


  // ...existing code...
  async testCache() {
    const key = 'ping';
    try {
      // Intentar primer formato (objeto options)
      try {
        await (this.cache as any).set(key, 'pong', { ttl: 60 });
      } catch (err) {
        // Si falla, intentar formato legacy (ttl número)
        await (this.cache as any).set(key, 'pong', 60);
      }

      const value = await this.cache.get<string>(key);
      console.log('🔍 testCache →', value);
      return value;
    } catch (err) {
      console.error('Cache error in testCache:', err);
      return null;
    }
  }
// ...existing code...
}
