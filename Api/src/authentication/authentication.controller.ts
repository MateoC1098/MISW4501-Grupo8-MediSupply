import {
  Body,
  Controller,
  Get,
  HttpCode,
  HttpException,
  HttpStatus,
  Post,
  Request,
} from '@nestjs/common';
import { UserDto } from './dtos/user.dto';
import { AuthenticationService } from './authentication.service';
import { WrongPasswordError } from './errors/wrong-password.error';
import { DisabledUserError } from './errors/disabled-user.error';

@Controller('authentication')
export class AuthenticationController {
  constructor(private authenticationService: AuthenticationService) {}

  @Get('profile')
  getProfile(@Request() req): Request {
    // eslint-disable-next-line @typescript-eslint/no-unsafe-return, @typescript-eslint/no-unsafe-member-access
    return req.user;
  }

  @Post('login')
  @HttpCode(HttpStatus.OK)
  async login(@Body() userDto: UserDto): Promise<void> {
    console.log('User login:', userDto.email);
    try {
      await this.authenticationService.login(userDto);
    } catch (error) {
      if (error instanceof WrongPasswordError)
        throw new HttpException('Forbidden', HttpStatus.FORBIDDEN);
      else if (error instanceof DisabledUserError)
        throw new HttpException('User account is disabled', HttpStatus.LOCKED);
      else throw error;
    }
  }

  @Post('logout')
  @HttpCode(HttpStatus.OK)
  async logout(@Body() userDto: UserDto): Promise<void> {
    console.log('User logout:', userDto.email);
    try {
      await this.authenticationService.logout(userDto.email);
    } catch (error) {
      if (error instanceof DisabledUserError)
        throw new HttpException('User account is disabled', HttpStatus.LOCKED);
      else throw error;
    }
  }
}
