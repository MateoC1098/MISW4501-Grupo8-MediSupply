import { HttpCode, Injectable } from '@nestjs/common';
import { UserDto } from './dtos/user.dto';
import { WrongPasswordError } from './errors/wrong-password.error';

@Injectable()
export class AuthenticationService {
  @HttpCode(200)
  async login(userDto: UserDto): Promise<boolean> {
    await new Promise((resolve) => setTimeout(resolve, 1000));
    console.log('User login service:', userDto);
    const { email, password } = userDto;
    if (email !== 'test@example.com' || password !== 'password')
      throw new WrongPasswordError();

    return true;
  }

  async logout(): Promise<boolean> {
    await new Promise((resolve) => setTimeout(resolve, 1000));
    console.log('User logout service');
    return true;
  }
}
