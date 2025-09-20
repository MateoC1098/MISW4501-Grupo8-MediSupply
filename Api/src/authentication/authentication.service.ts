import { HttpCode, Injectable } from '@nestjs/common';
import { UserDto } from './dtos/user.dto';
import { WrongPasswordError } from './errors/wrong-password.error';
import { UserRepository } from './repositories/user.repository';
import { User } from './entities/user.entity';

@Injectable()
export class AuthenticationService {
  constructor(private readonly userRepository: UserRepository) {}

  @HttpCode(200)
  async login(userDto: UserDto): Promise<boolean> {
    await new Promise((resolve) => setTimeout(resolve, 1000));
    console.log('User login service:', userDto);
    const { email, password } = userDto;

    console.log('💾 getAllUsers → from DB');
    const users: User[] = await this.userRepository.findByEmail(email);

    if (!Array.isArray(users) || users.length === 0)
      throw new WrongPasswordError();

    const passwordSaletd = this.saltPassword(password);
    // Aquí deberías implementar la lógica real de autenticación
    // Por ejemplo, verificar el email y la contraseña contra una base de datos
    console.log('Retrieved users:', users);
    console.log(
      'Comparing passwords:',
      passwordSaletd,
      'with',
      users[0].password,
    );

    if (passwordSaletd !== this.saltPassword(users[0].password))
      throw new WrongPasswordError();

    return true;
  }

  private saltPassword(password: string): string {
    // Simula el proceso de salado de la contraseña
    return password + 'S@LT';
  }

  @HttpCode(200)
  async logout(): Promise<boolean> {
    await new Promise((resolve) => setTimeout(resolve, 1000));
    console.log('User logout service');
    return true;
  }
}
