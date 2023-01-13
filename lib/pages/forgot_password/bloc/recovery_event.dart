part of 'recovery_bloc.dart';

abstract class RecoveryEvent extends Equatable {
  const RecoveryEvent();
}

class NewPasswordChanged extends RecoveryEvent {
  const NewPasswordChanged({required this.newPassword});

  final String newPassword;

  @override
  List<Object> get props => [newPassword];
}

class ConfirmNewPasswordChanged extends RecoveryEvent {
  const ConfirmNewPasswordChanged({
    required this.confirmNewPassword,
  });

  final String confirmNewPassword;

  @override
  List<Object> get props => [confirmNewPassword];
}

class CodeChanged extends RecoveryEvent {
  const CodeChanged({
    required this.code,
  });

  final String code;

  @override
  List<Object> get props => [code];
}

class ForgotEmailChanged extends RecoveryEvent {
  const ForgotEmailChanged({
    required this.forgotEmail,
  });

  final String forgotEmail;

  @override
  List<Object> get props => [forgotEmail];
}

class GetCodePressed extends RecoveryEvent {
  final int parentIndex;

  const GetCodePressed({required this.parentIndex});

  @override
  List<Object> get props => [parentIndex];
}

class SendPasswordPressed extends RecoveryEvent {
  const SendPasswordPressed(
      {required this.forgotEmail, required this.parentIndex});
  final String forgotEmail;
  final int parentIndex;
  @override
  List<Object> get props => [forgotEmail, parentIndex];
}
