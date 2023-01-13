import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutor/app_state.dart';
import 'package:tutor/services/aurh_servise.dart';
import 'package:tutor/utils/model/api_model.dart';
import 'package:tutor/utils/model/login/login_model.dart';

import 'package:tutor/utils/repository/user_repository.dart';
import 'package:tutor/utils/model/user_model.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required this.userRepository})
      // : assert(UserRepository != null),
      : super(AuthenticationUnauthenticated());

  final UserRepository userRepository;

  final AuthService _authService = AuthService();
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool validToken = await userRepository.isValidToken();
      if (validToken) {
        final Token token = await userRepository.refreshToken();
        await userRepository.saveAccessToken(tokenAccess: token.accessToken);
        await userRepository.saveRefreshToken(tokenRefresh: token.refreshToken);
        FFAppState().firstName = token.firstName;
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    } else if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.saveUser(user: event.user);
      await userRepository.saveAccessToken(tokenAccess: event.user.tokenAccess);
      await userRepository.saveRefreshToken(
          tokenRefresh: event.user.tokenRefresh);
      await userRepository.saveRefreshExp(user: event.user);
      yield AuthenticationAuthenticated();
    } else if (event is LogInGoogle) {
      final token = await _authService.signInWithGoogle();
      final user = await userRepository.sendSocialToken(
        token: token,
        provider: SocialProvider.Google,
        deviceToken: await _getDeviceID() ?? '',
      );
      add(LoggedIn(user: user));
    } else if (event is LogInFacebook) {
      final token = await _authService.signInWithFacebook();
      final user = await userRepository.sendSocialToken(
        token: token,
        provider: SocialProvider.Facebook,
        deviceToken: await _getDeviceID() ?? '',
      );
      add(LoggedIn(user: user));
    } else if (event is LoggedOut) {
      yield AuthenticationLoading();
      await _authService.signOut();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();

      // if (event is SendTokenLogin) {
      //   await sendFacebookToken(event.model);
      // }
    }

    // Future<void> sendFacebookToken(LoginModel model) async {
    //   return userRepository.sendLoginToken(model);
    // }
  }

  Future<String?> _getDeviceID() async {
    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo build = await _deviceInfoPlugin.androidInfo;
        return build.id; //UUID for Android
      } else if (Platform.isIOS) {
        final IosDeviceInfo data = await _deviceInfoPlugin.iosInfo;
        return data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      debugPrint('Failed to get platform version');
    }
    return null;
  }
}
