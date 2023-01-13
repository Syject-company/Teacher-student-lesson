import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:tutor/authication/bloc/authentication_bloc.dart';
import 'package:tutor/flutter_flow/flutter_flow_util.dart';
import 'package:tutor/pages/registration/fields/email.dart';
import 'package:tutor/pages/registration/fields/password.dart';
import 'package:tutor/utils/repository/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        email: email,
        status: Formz.validate([
          email,
          state.password,
        ]),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);

      yield state.copyWith(
        password: password,
        status: Formz.validate([
          state.email,
          password,
        ]),
      );
    }

    if (event is LoginButtonPressed) {
      yield LoginInitial();

      try {
        final user = await userRepository.authenticate(
          email: event.email,
          password: event.password,
          isParent: event.isParent,
        );

        authenticationBloc.add(LoggedIn(user: user));
        if (event.isParent == false) {
          yield LoginChildSuccess();
        } else {
          yield LoginSuccess();
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
