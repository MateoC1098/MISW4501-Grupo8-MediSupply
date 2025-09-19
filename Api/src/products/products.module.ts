import { Module } from '@nestjs/common';
import { ProductsService } from './products.service';
import { ProductsController } from './products.controller';
import { ProductRepository } from './repository/product.repository';
//import { ProductRepository } from './repository/product.repository';

@Module({
  controllers: [ProductsController],
  providers: [
    ProductsService,
    {
      provide: 'IProductRepository',
      useClass: ProductRepository,
    },
  ],
})
export class ProductsModule {}
