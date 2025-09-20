import {
  Body,
  Controller,
  HttpException,
  HttpStatus,
  Post,
} from '@nestjs/common';
import { UserDto } from './dtos/user.dto';
import { AuthenticationService } from './authentication.service';
import { WrongPasswordError } from './errors/wrong-password.error';

@Controller('authentication')
export class AuthenticationController {
  constructor(private authenticationService: AuthenticationService) {}

  @Post('login')
  async login(@Body() userDto: UserDto): Promise<void> {
    console.log('User login:', userDto);
    try {
      await this.authenticationService.login(userDto);
    } catch (error) {
      if (error instanceof WrongPasswordError)
        throw new HttpException('Forbidden', HttpStatus.FORBIDDEN);
      else throw error;
    }
  }

  @Post('logout')
  async logout(): Promise<void> {
    console.log('User logout');
    await this.authenticationService.logout();
  }
}
