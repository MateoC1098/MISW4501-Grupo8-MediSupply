import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PubsubController } from './pubsub/pubsub.controller';
import { RedisController } from './redis/redis.controller';
import { PubsubService } from './pubsub/pubsub.service';

@Module({
  imports: [],
  controllers: [AppController, PubsubController, RedisController],
  providers: [AppService, PubsubService],
})
export class AppModule {}
