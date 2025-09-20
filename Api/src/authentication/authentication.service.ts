import { HttpCode, Injectable } from '@nestjs/common';
import { UserDto } from './dtos/user.dto';
import { WrongPasswordError } from './errors/wrong-password.error';
import { UserRepository } from './repositories/user.repository';
import { User } from './entities/user.entity';
import { DisabledUserError } from './errors/disabled-user.error';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthenticationService {
  private readonly NUM_MAX_INTENTOS_FALLIDOS = 5;

  constructor(
    private readonly userRepository: UserRepository,
    private jwtService: JwtService,
  ) {}

  @HttpCode(200)
  async login(userDto: UserDto): Promise<string> {
    await new Promise((resolve) => setTimeout(resolve, 1000));
    console.log('User login service:', userDto);
    const { email, password } = userDto;

    const users: User[] = await this.userRepository.findByEmail(email);
    if (!Array.isArray(users) || users.length === 0)
      throw new WrongPasswordError(); // Usuario no encontrado, pero eso no se dice

    console.log('Users:', users);
    const passwordSaletd = this.saltPassword(password, `${users[0].id}`);
    // Verificar si el usuario está habilitado
    if (!users[0].habilitado) throw new DisabledUserError();
    else {
      console.log('User is enabled');
      if (
        passwordSaletd !==
        this.saltPassword(users[0].password, `${users[0].id}`)
      ) {
        // Password incorrecto
        users[0].intentos_fallidos_login += 1;
        if (
          users[0].intentos_fallidos_login >= this.NUM_MAX_INTENTOS_FALLIDOS
        ) {
          users[0].habilitado = false;
          console.log(
            'Cuenta de usuario deshabilitada por múltiples intentos fallidos de inicio de sesión',
          );
        } else {
          console.log(
            `Intento fallido de inicio de sesión ${users[0].intentos_fallidos_login} para el usuario ${users[0].email}`,
          );
          await this.userRepository.updateUser(users[0]);
          throw new WrongPasswordError();
        } // fi

        await this.userRepository.updateUser(users[0]);
        throw new DisabledUserError();
      } // fi
    } // fi

    const payload = { id: users[0].id, user: users[0] };
    const access_token = await this.jwtService.signAsync(payload);
    return access_token;
  }

  private saltPassword(password: string, salt: string): string {
    return `${password}${salt}`;
  }

  @HttpCode(200)
  async logout(email: string): Promise<boolean> {
    await new Promise((resolve) => setTimeout(resolve, 1000));
    console.log('User logout service:', email);
    return true;
  }
}
