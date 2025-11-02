import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:invoapp/core/env/env.dart';
import 'package:invoapp/core/util/error_handler/error_handler.dart';

import '../../domain/entity/token.dart';
import '../../domain/entity/user.dart';

abstract class LoginRepository {
  Future<Either<ErrorState, Token>> login(String email, String password);

  Future<void> logout();

  Future<Token?> getCurrentToken({required String token});

  Future<User?> getCurrentUser();

  Future<void> saveToken(Token token);

  Future<void> saveUser(User user);

  Future<void> clearAll();
}

class LoginRepositoryImpl implements LoginRepository {
  final FlutterSecureStorage _storage;

  final String _keyToken = Env.keyToken;
  final String _keyUserEmail = Env.keyUserEmail;
  final String _loginUrl = Env.loginUrl;
  final String _baseUrl = Env.baseUrl;
  late final Dio _dio;

  LoginRepositoryImpl(this._storage) {
    _dio = Dio(BaseOptions(baseUrl: '$_baseUrl$_loginUrl'));
  }

  @override
  Future<Either<ErrorState, Token>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    return await ErrorHandler.callApi(
      api: () => _dio.post(
        '',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'sign_in': {
            'email': email,
            'password': password,
          },
        },
      ),
      parse: (data) {
        return Token(token: data['token'], expiresAt: _getExpiryDate(data['token']));
      },
    );
  }

  @override
  Future<void> logout() async {
    await clearAll();
  }

  @override
  Future<Token> getCurrentToken({required String token}) async {
    try {
      final tokenStr = await _storage.read(key: _keyToken);
      if (tokenStr == null) return Token(token: token);

      final tokenMap = Map<String, dynamic>.from({
        'token': tokenStr,
        'expiresAt': _getExpiryDate(tokenStr).toIso8601String(),
      });
      return Token.fromJson(tokenMap);
    } catch (e) {
      return Token(token: token);
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final userEmail = await _storage.read(key: _keyUserEmail);
      if (userEmail == null) return null;

      return User(
        email: await _storage.read(key: _keyUserEmail) ?? '',
        lastLogin: DateTime.now(),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveToken(Token token) async {
    await _storage.write(key: _keyToken, value: token.token);
  }

  @override
  Future<void> saveUser(User user) async {
    await _storage.write(key: _keyUserEmail, value: user.email);
  }

  @override
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  DateTime _getExpiryDate(String token) {
    final parts = token.split('.');

    if (parts.length != 3) throw Exception('Token inválido');

    final payload = json.decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

    final exp = payload['exp'];
    final expDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    return expDate;
  }
}
