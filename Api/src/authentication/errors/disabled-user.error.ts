export class DisabledUserError extends Error {
  constructor() {
    super('The user is disabled');
    this.name = 'DisabledUserError';
  }
}
