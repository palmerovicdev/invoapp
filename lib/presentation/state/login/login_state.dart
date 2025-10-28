part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.user,
    this.token,
  });

  final AuthStatus status;
  final String? errorMessage;
  final User? user;
  final Token? token;

  @override
  List<Object?> get props => [status, errorMessage];

  bool get isAuthenticated => status == AuthStatus.authenticated;

  bool get isUnauthenticated => status == AuthStatus.unauthenticated;

  bool get isChecking => status == AuthStatus.checking;

  bool get hasError => status == AuthStatus.error;

  bool get hasFailed => status == AuthStatus.failed;

  LoginState copyWith({
    AuthStatus? status,
    String? errorMessage,
    User? user,
    Token? token,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  LoginState clearError() {
    return LoginState(
      status: AuthStatus.unauthenticated,
      errorMessage: null,
      user: user,
      token: token,
    );
  }
}
