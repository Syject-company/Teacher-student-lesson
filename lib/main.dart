import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/authication/bloc/authentication_bloc.dart';
import 'package:tutor/navigation/parent_nav_page.dart';
import 'package:tutor/pages/registration/bloc/reg_bloc.dart';
import 'package:tutor/pages/welcome/welcome_widget.dart';
import 'package:tutor/utils/repository/user_repository.dart';
import "package:flutter/services.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pages/parent_pages/lessons_page/bloc/lessons_bloc.dart';
import 'pages/parent_pages/rewards_page/bloc/rewards_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  // ByteData data =
  //     await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(App(
    userRepository: UserRepository(),
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key? key, required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
              providers: [
                BlocProvider<RegistrationBloc>(
                    create: (context) =>
                        RegistrationBloc(userRepository: userRepository)),
                BlocProvider<LessonsBloc>(
                    create: (context) =>
                        LessonsBloc(userRepository: userRepository)),
                BlocProvider<RewardsBloc>(
                    create: (context) =>
                        RewardsBloc(userRepository: userRepository)),
                BlocProvider<AuthenticationBloc>(
                    create: (context) =>
                        AuthenticationBloc(userRepository: userRepository)
                          ..add(AppStarted())),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  brightness: Brightness.light,
                  scrollbarTheme: ScrollbarThemeData(
                    crossAxisMargin: 3,
                    minThumbLength: 50,
                    trackBorderColor: MaterialStateProperty.all(
                        Color.fromRGBO(217, 217, 217, 1)),
                    trackColor: MaterialStateProperty.all(
                        Color.fromRGBO(217, 217, 217, 1)),
                    thumbVisibility: MaterialStateProperty.all(true),
                    trackVisibility: MaterialStateProperty.all(true),
                    radius: const Radius.circular(10.0),
                    thumbColor: MaterialStateProperty.all(
                        Color.fromRGBO(43, 192, 239, 1)),
                    thickness: MaterialStateProperty.all(7.0),
                  ),
                ),
                darkTheme: ThemeData(brightness: Brightness.light),
                home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    if (state is AuthenticationUninitialized) {
                      return WelcomeWidget();
                    }
                    if (state is AuthenticationAuthenticated) {
                      return NavBarPage(initialPage: 'HomePage');
                      // return WelcomeWidget();
                    } else {
                      return WelcomeWidget();
                      // return RegistrationPage(userRepository: userRepository);
                    }
                  },
                ),
              ));
        });
  }
}
