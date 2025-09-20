import { Inject, Injectable } from '@nestjs/common';
import { User } from '../entities/user.entity';
import { Knex } from 'knex';

@Injectable()
export class UserRepository {
  constructor(@Inject('KNEX_CONNECTION') private readonly knex: Knex) {}

  async findAll(): Promise<User[]> {
    return await this.knex<User>('users').select('*').orderBy('id', 'asc');
  }

  async findMany(limit: number): Promise<User[]> {
    const l = Number(limit) > 0 ? Math.floor(Number(limit)) : 10;
    return await this.knex<User>('users')
      .select('*')
      .orderBy('id', 'asc')
      .limit(l);
  }
  // Aquí irían los métodos para interactuar con la base de datos

  async findById(id: number): Promise<User[]> {
    return await this.knex<User>('users')
      .select('*')
      .where({ id })
      .orderBy('id', 'asc')
      .limit(1);
  }

  async findByEmail(email: string): Promise<User[]> {
    return await this.knex<User>('users')
      .select('*')
      .where({ email })
      .orderBy('email', 'asc');
    // .limit(1);
  }

  async updateUser(user: User): Promise<void> {
    await this.knex<User>('users').update(user).where({ id: user.id });
  }
}
