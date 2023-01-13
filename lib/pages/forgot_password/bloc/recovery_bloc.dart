import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:tutor/authication/bloc/authentication_bloc.dart';
import 'package:tutor/pages/registration/fields/code.dart';
import 'package:tutor/pages/registration/fields/confirm_password.dart';
import 'package:tutor/pages/registration/fields/email_recovery.dart';
import 'package:tutor/pages/registration/fields/password.dart';
import 'package:tutor/utils/repository/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'recovery_event.dart';
part 'recovery_state.dart';

class RecoveryBloc extends Bloc<RecoveryEvent, RecoveryState> {
  final UserRepository userRepository;

  RecoveryBloc({
    required this.userRepository,
  })  : assert(userRepository != null),
        super(RecoveryState());

  @override
  Stream<RecoveryState> mapEventToState(RecoveryEvent event) async* {
    if (event is ForgotEmailChanged) {
      final forgotEmail = EmailRecovery.dirty(event.forgotEmail);
      yield state.copyWith(
        forgotEmail: forgotEmail,
        status: Formz.validate([forgotEmail]),
      );
      print(state.forgotEmail.value);
    } else if (event is NewPasswordChanged) {
      print(state.forgotEmail.value);
      final newPassword = Password.dirty(event.newPassword);
      final confirmNew = ConfirmPassword.dirty(
        password: newPassword.value,
        value: state.confirmNewPassword.value,
      );
      yield state.copyWith(
        newPassword: newPassword,
        status: Formz.validate([
          state.code,
          newPassword,
          confirmNew,
        ]),
      );
    } else if (event is ConfirmNewPasswordChanged) {
      final confirmNewPassword = ConfirmPassword.dirty(
          password: state.newPassword.value, value: event.confirmNewPassword);

      yield state.copyWith(
        confirmNewPassword: confirmNewPassword,
        status: Formz.validate([
          state.code,
          state.newPassword,
          confirmNewPassword,
        ]),
      );
    } else if (event is CodeChanged) {
      final emailCode = Code.dirty(event.code);

      yield state.copyWith(
        code: emailCode,
        status: Formz.validate([
          state.confirmNewPassword,
          state.newPassword,
          emailCode,
        ]),
      );
    }
    if (event is GetCodePressed) {
      try {
        var code = await userRepository.getCode(
          email: state.forgotEmail.value,
          parentIndex: event.parentIndex,
        );

        yield MailSendedSuccess();
      } catch (error) {
        yield ForgotPasswordFailure(error: error.toString());
      }
    }
    if (event is SendPasswordPressed) {
      try {
        var respond = await userRepository.sendNewPassword(
            email: event.forgotEmail,
            code: state.code.value,
            newPassword: state.confirmNewPassword.value,
            parentIndex: event.parentIndex);
        print('respondFromBloc$respond');
        if (respond == null) {
          yield PassSendedSuccess();
        }
      } catch (_error) {
        yield ForgotPasswordFailure(error: _error.toString());
      }
    }
  }
}
