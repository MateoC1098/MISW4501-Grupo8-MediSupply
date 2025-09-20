import { Module } from '@nestjs/common';
import { AuthenticationController } from './authentication.controller';
import { AuthenticationService } from './authentication.service';
import { UsersModule } from '../users/users.module';
import { UserRepository } from './repositories/user.repository';
import { DatabaseModule } from '../database/database.module';
import { JwtModule } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { AuthenticationGuard } from './authentication.guard';
import { APP_GUARD } from '@nestjs/core';

@Module({
  imports: [
    UsersModule,
    DatabaseModule,
    JwtModule.registerAsync({
      global: true,
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => ({
        secret: configService.get<string>('JWT_SECRET'),
        signOptions: { expiresIn: '1440s' }, // 24 horas
      }),
    }),
  ],
  providers: [
    AuthenticationService,
    UserRepository,
    {
      provide: APP_GUARD,
      useClass: AuthenticationGuard,
    },
  ],
  controllers: [AuthenticationController],
  exports: [AuthenticationService],
})
export class AuthenticationModule {}
