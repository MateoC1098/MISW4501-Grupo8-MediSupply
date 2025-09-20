import { Module, SetMetadata } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { DatabaseModule } from './database/database.module';
import { ProductsModule } from './products/products.module';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { createKeyv } from '@keyv/redis';
import { CacheModule as NestCacheModule } from '@nestjs/cache-manager';
import { AuthenticationModule } from './authentication/authentication.module';
import { UsersModule } from './users/users.module';

export const IS_PUBLIC_KEY = 'isPublic';
export const Public = () => SetMetadata(IS_PUBLIC_KEY, true);

@Module({
  imports: [
    DatabaseModule,
    AuthenticationModule,
    ProductsModule,
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    NestCacheModule.registerAsync({
      isGlobal: true,
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (config: ConfigService) => ({
        store: createKeyv(
          `redis://${config.get<string>('REDIS_HOST') || 'localhost'}:${config.get<number>('REDIS_PORT') || 6379}`,
        ),
        ttl: config.get<number>('CACHE_TTL') || 600000, // TTL en milisegundos
      }),
    }),
    UsersModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
