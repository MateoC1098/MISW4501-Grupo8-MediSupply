import {
  Controller,
  Get,
  Query,
  Post,
  Body,
  Put,
  Param,
  Delete,
} from '@nestjs/common';
import { CreateCatDto, UpdateCatDto, ListAllEntities } from './dto';
import { PubsubService } from './pubsub.service';

@Controller('pubsub')
export class PubsubController {
  memoryArray: Array<string>;

  constructor(private readonly pubSubService: PubsubService) {
    this.memoryArray = [];
  }

  @Post()
  async create(@Body() createCatDto: CreateCatDto) {
    await this.pubSubService.publish('cats', createCatDto);
    return 'This action adds a new cat';
  }

  @Get()
  findAll(@Query() query: ListAllEntities) {
    return `This action returns all cats (limit: ${query.limit} items)`;
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return `This action returns a #${id} cat`;
  }

  @Put(':id')
  update(@Param('id') id: string, @Body() updateCatDto: UpdateCatDto) {
    return `This action updates a #${id} cat JSON: ${JSON.stringify(updateCatDto)}`;
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return `This action removes a #${id} cat`;
  }
}
