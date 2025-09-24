import {
  Controller,
  DefaultValuePipe,
  Get,
  ParseIntPipe,
  Query,
} from '@nestjs/common';
import { ProductsService } from './products.service';

@Controller('products')
export class ProductsController {
  constructor(private readonly productsService: ProductsService) {}

  @Get('/cache')
  async getAllProducts(
    @Query('limit', new DefaultValuePipe(10), ParseIntPipe) limit: number,
  ) {
    return this.productsService.getAllProductsUsingCache(limit);
  }

  @Get('/no-cache')
  async getAllProductsNoCache(
    @Query('limit', new DefaultValuePipe(10), ParseIntPipe) limit: number,
  ) {
    return this.productsService.getAllProductsWithOutCache(limit);
  }

  @Get('ping')
  async ping() {
    return this.productsService.testCache();
  }
}
