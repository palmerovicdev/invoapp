import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invoapp/domain/entity/token.dart';
import 'package:invoapp/service/invoice_service.dart';

import '../../../core/auth_status.dart';
import '../../../core/locator.dart';
import '../../../domain/entity/user.dart';
import '../../../service/login_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService _loginService;

  LoginBloc(this._loginService) : super(LoginState()) {
    on<LoginCheckSession>(_onCheckSession);
    on<LoginSubmit>(_onSubmit);
    on<LoginLogout>(_onLogout);
    on<LoginClearError>(_onClearError);
  }

  Future<void> _onCheckSession(
    LoginCheckSession event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.checking));

    await Future.delayed(const Duration(seconds: 1));
    try {
      final token = await _loginService.checkSession();
      if (token == null || !token.isValid) {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
        return;
      }

      final user = await _loginService.getCurrentUser();
      await locator.get<InvoiceService>().getInvoices(
        page: 1,
        token: token.token,
      );
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          token: token,
          user: user,
        ),
      );
    } catch (e, st) {
      log('Error en _onCheckSession: $e', stackTrace: st);

      final message = _mapLoginErrorToMessage(e.toString());

      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: message,
        ),
      );
    }
  }

  Future<void> _onSubmit(
    LoginSubmit event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.checking));

    try {
      final token = await _loginService.login(event.email, event.password);
      final user = await _loginService.getCurrentUser();
      await locator.get<InvoiceService>().getInvoices(
        page: 1,
        token: token.token,
      );
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          token: token,
          user: user,
          clearError: true,
        ),
      );
    } catch (e, st) {
      log('Error en _onSubmit (login): $e', stackTrace: st);

      final message = _mapLoginErrorToMessage(e.toString());

      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: message,
        ),
      );
    }
  }

  Future<void> _onLogout(
    LoginLogout event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.checking));

    try {
      await _loginService.logout();
      emit(const LoginState(status: AuthStatus.unauthenticated));
    } catch (e, st) {
      log('Error en _onLogout: $e', stackTrace: st);
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onClearError(
    LoginClearError event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(clearError: true));
  }

  String _mapLoginErrorToMessage(String error) {
    final errorMap = {
      'INVALID_CREDENTIALS': 'Credenciales inválidas',
      'SERVER_ERROR': 'Error del servidor',
      'NETWORK_ERROR': 'Error de red',
    };

    final entry = errorMap.entries.firstWhere(
      (e) => error.contains(e.key),
      orElse: () => const MapEntry('', 'Error inesperado'),
    );

    return entry.value;
  }
}
