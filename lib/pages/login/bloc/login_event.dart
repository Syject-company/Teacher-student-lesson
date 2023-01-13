part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class PasswordChanged extends LoginEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class EmailChanged extends LoginEvent {
  const EmailChanged({
    required this.email,
  });

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginButtonPressed extends LoginEvent {
  final bool isParent;
  final String email;
  final String password;

  const LoginButtonPressed(
      {required this.isParent, required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginButtonPressed { email: $email, password: $password }';
}
