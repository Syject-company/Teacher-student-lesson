import 'package:equatable/equatable.dart';

abstract class RegEvent extends Equatable {
  const RegEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends RegEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class EmailChanged extends RegEvent {
  const EmailChanged({
    required this.email,
  });

  final String email;

  @override
  List<Object> get props => [email];
}

class DateOfBirthChanged extends RegEvent {
  const DateOfBirthChanged({
    required this.dateOfBirth,
  });

  final String dateOfBirth;

  @override
  List<Object> get props => [dateOfBirth];
}

class AvatarSelected extends RegEvent {
  const AvatarSelected({
    required this.childImageId,
  });

  final String childImageId;

  @override
  List<Object> get props => [childImageId];
}

class CountryChanged extends RegEvent {
  const CountryChanged({
    required this.country,
  });

  final String country;

  @override
  List<Object> get props => [country];
}

class RecoveryEmailChanged extends RegEvent {
  const RecoveryEmailChanged({
    required this.email_recovery,
  });

  final String email_recovery;

  @override
  List<Object> get props => [email_recovery];
}

class PasswordChanged extends RegEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class OldPasswordChanged extends RegEvent {
  const OldPasswordChanged({required this.oldPassword});

  final String oldPassword;

  @override
  List<Object> get props => [oldPassword];
}

class ReNewPasswordChanged extends RegEvent {
  const ReNewPasswordChanged({required this.reNewPassword});

  final String reNewPassword;

  @override
  List<Object> get props => [reNewPassword];
}

class ConfirmPasswordChanged extends RegEvent {
  const ConfirmPasswordChanged({
    required this.confirmPassword,
  });

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class LoadPhoto extends RegEvent {}

class DeleteParentEvent extends RegEvent {}

class EmailRecoverySubmitted extends RegEvent {}

class PasswordResetSubmitted extends RegEvent {}

class FormSubmitted extends RegEvent {}

class ChildFormSubmitted extends RegEvent {}

class SendNewUserData extends RegEvent {}

class RenewParentPassword extends RegEvent {}
