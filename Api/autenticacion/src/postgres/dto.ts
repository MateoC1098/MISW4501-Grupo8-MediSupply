class CreateCatDto {
  name: string;
  age: number;
  color: string;
}

class UpdateCatDto {
  name?: string;
  age?: number;
  color?: string;
}

class ListAllEntities {
  limit: number;
  offset: number;
}

export { CreateCatDto, UpdateCatDto, ListAllEntities };
