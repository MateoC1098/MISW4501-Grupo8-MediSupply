export interface User {
  id: number;
  email: string;
  password: string;
  intentos_fallidos_login: number;
  habilitado: boolean;
  token: string | null;
  created_at: Date;
}
