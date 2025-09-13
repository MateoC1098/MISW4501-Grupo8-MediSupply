import { Test, TestingModule } from '@nestjs/testing';
import { PubsubService } from './pubsub.service';

describe('PubsubService', () => {
  let service: PubsubService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [PubsubService],
    }).compile();

    service = module.get<PubsubService>(PubsubService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
