import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../data/repository/login_repository.dart';
import '../service/login_service.dart';

final locator = GetIt.instance;

Future<void> setUpLocator() async {
  const secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  locator.registerSingleton<FlutterSecureStorage>(secureStorage);

  locator.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(locator<FlutterSecureStorage>()),
  );
  locator.registerLazySingleton<LoginService>(
    () => LoginServiceImpl(locator<LoginRepository>()),
  );
}

LoginService get loginService => locator.get<LoginService>();
