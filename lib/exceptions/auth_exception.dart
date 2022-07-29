// ignore: camel_case_types
class authException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS':
        'Já tem gente aqui com esse e-mail. É você? Faça login, então!',
    'OPERATION_NOT_ALLOWED': 'Não dá pra fazer isso aqui não!',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Tá de brincadeira comigo? Agora não!',
    'EMAIL_NOT_FOUND': 'Não encontrei teu e-mail aqui não!',
    'INVALID_PASSWORD': 'Você digitou a senha errada. Dedo gordo?',
    'USER_DISABLED': 'Amigo, te cancelaram!',
  };

  final String key;

  authException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ih! Deu ruim!';
  }
}
