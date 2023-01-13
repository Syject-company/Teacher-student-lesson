part of 'recovery_bloc.dart';

class RecoveryState extends Equatable {
  const RecoveryState(
      {this.forgotEmail = const EmailRecovery.pure(),
      this.newPassword = const Password.pure(),
      this.parentIndex,
      this.code = const Code.pure(),
      this.confirmNewPassword = const ConfirmPassword.pure(),
      this.status = FormzStatus.pure,
      this.errorMessage = null});

  final EmailRecovery forgotEmail;
  final Password newPassword;
  final Code code;
  final int? parentIndex;
  final ConfirmPassword confirmNewPassword;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props =>
      [status, forgotEmail, newPassword, confirmNewPassword, code, parentIndex];

  RecoveryState copyWith({
    EmailRecovery? forgotEmail,
    FormzStatus? status,
    String? errorMessage,
    int? parentIndex,
    Code? code,
    Password? newPassword,
    ConfirmPassword? confirmNewPassword,
  }) {
    return RecoveryState(
        forgotEmail: forgotEmail ?? this.forgotEmail,
        newPassword: newPassword ?? this.newPassword,
        status: status ?? this.status,
        code: code ?? this.code,
        parentIndex: parentIndex ?? this.parentIndex,
        confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
        errorMessage: errorMessage);
  }
}

class MailSendedSuccess extends RecoveryState {}

class PassSendedSuccess extends RecoveryState {}

class ForgotPasswordFailure extends RecoveryState {
  final String error;

  const ForgotPasswordFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' LoginFailure { error: $error }';
}
