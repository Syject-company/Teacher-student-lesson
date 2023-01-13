import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:tutor/authication/bloc/authentication_bloc.dart';
import 'package:tutor/pages/registration/fields/child_image.dart';

import 'package:tutor/pages/registration/fields/name.dart';
import 'package:tutor/pages/registration/fields/oldPassword.dart';
import 'package:tutor/pages/registration/fields/year_of_birth.dart';
import 'package:tutor/utils/repository/user_repository.dart';
import 'package:tutor/pages/registration/fields/confirm_password.dart';
import 'package:tutor/pages/registration/fields/email.dart';
import 'package:tutor/pages/registration/fields/password.dart';
import '../../../services/dio_client.dart';
import '../../../utils/repository/photo_repository.dart';
import 'reg_event.dart';
import 'reg_state.dart';

final _base = "http://tutoronhandapi-dev.us-east-1.elasticbeanstalk.com";
final _deleteParentURL = _base + "/parent/ParentUser/Delete/";
final _renewParentPass = _base + "/parent/ParentUser/ChangePassword/";

class RegistrationBloc extends Bloc<RegEvent, RegState> {
  final UserRepository userRepository;
  final AuthenticationBloc? authenticationBloc;
  final dio = DioClient();
  RegistrationBloc({
    required this.userRepository,
    this.authenticationBloc,
  })  : assert(userRepository != null),
        super(RegState());

  @override
  Stream<RegState> mapEventToState(RegEvent event) async* {
    if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        email: email,
        status: Formz.validate([
          email,
          state.password,
          state.confirmPassword,
        ]),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      final confirm = ConfirmPassword.dirty(
        password: password.value,
        value: state.confirmPassword.value,
      );
      yield state.copyWith(
        password: password,
        status: Formz.validate([
          state.email,
          password,
          confirm,
        ]),
      );
    } else if (event is ConfirmPasswordChanged) {
      final password = ConfirmPassword.dirty(
          password: state.password.value, value: event.confirmPassword);

      yield state.copyWith(
        confirmPassword: password,
        status: Formz.validate([
          state.email,
          state.password,
          password,
        ]),
      );
    } else if (event is NameChanged) {
      final name = Name.dirty(event.name);
      yield state.copyWith(
        name: name,
        status: Formz.validate([
          name,
        ]),
      );
    } else if (event is DateOfBirthChanged) {
      print(event.dateOfBirth);

      final dateOfBirth = YearOfBirth.pure(event.dateOfBirth);

      yield state.copyWith(
        dateOfBirth: dateOfBirth,
      );
    } else if (event is AvatarSelected) {
      final childImageId = ChildImg.dirty(event.childImageId);
      yield state.copyWith(
        childImageId: childImageId,
      );
    } else if (event is CountryChanged) {
      final country = ChildImg.dirty(event.country);
      yield state.copyWith(
        country: country,
      );
    } else if (event is LoadPhoto) {
      final listOfPhoto =
          await PhotoRepository(dioClient: DioClient()).fetchChildsPhoto();

      yield state.copyWith(
        photo: listOfPhoto,
      );
    } else if (event is DeleteParentEvent) {
      try {
        var errorMessage = await dio.remove(_deleteParentURL);

        if (errorMessage == "" || errorMessage?.length == 36)
          yield state.copyWith(errorMessage: 'Parent Deleted');
        userRepository.deleteToken();
      } catch (error) {
        yield state.copyWith(errorMessage: error.toString());
      }
    }

    if (event is FormSubmitted) {
      if (!state.status.isValidated) return;

      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        var errorMessage = await userRepository.register(
          email: state.email.value,
          password: state.password.value,
          country: state.country.value,
          name: state.name.value,
        );
        final user = await userRepository.authenticate(
          email: state.email.value,
          password: state.password.value,
          isParent: true,
        );
        await userRepository.saveUser(user: user);
        await userRepository.saveAccessToken(tokenAccess: user.tokenAccess);
        await userRepository.saveRefreshToken(tokenRefresh: user.tokenRefresh);
        await userRepository.saveRefreshExp(user: user);
        if (errorMessage == "" || errorMessage.length == 38)
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        else
          yield state.copyWith(
              status: FormzStatus.submissionFailure,
              errorMessage: errorMessage);
      } catch (error) {
        yield state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: error.toString());
      }
    }
    if (event is ChildFormSubmitted) {
      if (!state.status.isValidated) return;

      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        var errorMessage = await userRepository.childRegisterStart(
          email: state.email.value,
          password: state.password.value,
          name: state.name.value,
          childImageId: state.childImageId.value,
          birthDate: state.dateOfBirth.value,
        );

        if (errorMessage == "" || errorMessage.length == 36)
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        else
          yield state.copyWith(
              status: FormzStatus.submissionFailure,
              errorMessage: errorMessage.toString());
      } catch (error) {
        yield state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: error.toString());
      }
    } else if (event is OldPasswordChanged) {
      final oldPassword = OldPassword.dirty(event.oldPassword);

      yield state.copyWith(
        oldPassword: oldPassword,
        status: Formz.validate([state.oldPassword]),
      );
    } else if (event is RenewParentPassword) {
      print('${state.oldPassword.value}${state.confirmPassword.value}');
      try {
        var errorMessage = await dio.putNewParentPassword(
          _renewParentPass,
          state.oldPassword.value,
          state.confirmPassword.value,
        );

        if (errorMessage == true)
          yield state.copyWith(errorMessage: 'Password Changed');
      } catch (error) {
        yield FailureState(error: error.toString());
        yield state.copyWith(errorMessage: error.toString());
      }
    }
  }
}
