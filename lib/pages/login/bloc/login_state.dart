part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure,
      this.errorMessage = null});

  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [email, password, status];

  LoginState copyWith(
      {Email? email,
      Password? password,
      FormzStatus? status,
      String? errorMessage}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        errorMessage: errorMessage);
  }
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginChildSuccess extends LoginState {}

class ForgotChildSuccess extends LoginState {}

class ForgotParentSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' LoginFailure { error: $error }';
}

class ForgotPasswordFailure extends LoginState {
  final String error;

  const ForgotPasswordFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' LoginFailure { error: $error }';
}
