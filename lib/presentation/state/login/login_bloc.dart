import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invoapp/domain/entity/token.dart';

import '../../../core/auth_status.dart';
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

      var isInvalidToken = token == null || !token.isValid;

      if (isInvalidToken) {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
        return;
      }

      final user = await _loginService.getCurrentUser();
      emit(state.copyWith(status: AuthStatus.authenticated, token: token, user: user));
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'Failed to check session.',
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
      emit(state.copyWith(status: AuthStatus.initial, token: token, user: user, errorMessage: null, isCheck: false));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(status: AuthStatus.authenticated, token: token, user: user, errorMessage: null));
    } catch (e) {
      String message = 'UNEXPECTED_ERROR';
      final error = e.toString();

      if (error.contains('INVALID_CREDENTIALS')) {
        message = 'INVALID_CREDENTIALS';
      } else if (error.contains('SERVER_ERROR')) {
        message = 'SERVER_ERROR';
      } else if (error.contains('NETWORK_ERROR')) {
        message = 'NETWORK_ERROR';
      } else if (error.contains('UNEXPECTED_ERROR')) {
        message = 'UNEXPECTED_ERROR';
      }

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
    } catch (e) {
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
    emit(state.clearError());
  }
}
