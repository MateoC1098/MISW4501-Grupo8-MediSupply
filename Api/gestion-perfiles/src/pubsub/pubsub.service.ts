import { Injectable } from '@nestjs/common';
import { PubSub } from '@google-cloud/pubsub';
import { CreateCatDto } from './dto';

@Injectable()
export class PubsubService {
  private pubsub: PubSub;

  constructor() {
    this.pubsub = new PubSub({ projectId: process.env.GOOGLE_CLOUD_PROJECT });
  }

  async publish(topic: string = 'topic-pedidos', createCatDto: CreateCatDto) {
    const dataBuffer = Buffer.from(JSON.stringify(createCatDto));
    return await this.pubsub.topic(topic).publishMessage({ data: dataBuffer });
  }
}
