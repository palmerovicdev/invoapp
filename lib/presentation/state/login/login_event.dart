part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginCheckSession extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginSubmit extends LoginEvent {
  final String email;
  final String password;

  const LoginSubmit(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class LoginLogout extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginClearError extends LoginEvent {
  @override
  List<Object?> get props => [];
}
