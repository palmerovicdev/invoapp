import 'package:envied/envied.dart';

part 'gen/env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'BASE_URL', obfuscate: true)
  static final String baseUrl = _Env.baseUrl;
  @EnviedField(varName: 'LOGIN_URL', obfuscate: true)
  static final String loginUrl = _Env.loginUrl;
  @EnviedField(varName: 'INVOICES_URL', obfuscate: true)
  static final String invoicesUrl = _Env.invoicesUrl;
  @EnviedField(varName: 'KEY_TOKEN', obfuscate: true)
  static final String keyToken = _Env.keyToken;
  @EnviedField(varName: 'KEY_USER_EMAIL', obfuscate: true)
  static final String keyUserEmail = _Env.keyUserEmail;
}
