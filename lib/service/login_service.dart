import '../data/repository/login_repository.dart';
import '../domain/entity/token.dart';
import '../domain/entity/user.dart';

abstract class LoginService {
  Future<Token> login(String email, String password);

  Future<void> logout();

  Future<Token?> checkSession();

  Future<User?> getCurrentUser();
}

class LoginServiceImpl implements LoginService {
  final LoginRepository _repository;

  LoginServiceImpl(this._repository);

  @override
  Future<Token> login(String email, String password) async => await _repository.login(email, password);

  @override
  Future<void> logout() async => await _repository.logout();

  @override
  Future<Token?> checkSession() async {
    final token = await _repository.getCurrentToken();
    final isValidToken = token != null && token.isValid;

    if (isValidToken) return token;

    await _repository.clearAll();
    return null;
  }

  @override
  Future<User?> getCurrentUser() async => await _repository.getCurrentUser();
}
