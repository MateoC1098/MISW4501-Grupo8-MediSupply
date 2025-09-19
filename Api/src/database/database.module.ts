import { Global, Module } from '@nestjs/common';
import knex, { Knex } from 'knex';
import { ConfigService } from '@nestjs/config';

const dbProvider = {
  provide: 'KNEX_CONNECTION',
  inject: [ConfigService],
  useFactory: async (configService: ConfigService): Promise<Knex> => {
    return knex({
      client: 'pg',
      connection: {
        host: configService.get<string>('DB_HOST'),
        port: configService.get<number>('DB_PORT'),
        user: configService.get<string>('DB_USER'),
        password: configService.get<string>('DB_PASS'),
        database: configService.get<string>('DB_NAME'),
      },
    });
  },
};

@Global()
@Module({
  providers: [dbProvider],
  exports: ['KNEX_CONNECTION'],
})
export class DatabaseModule {}
