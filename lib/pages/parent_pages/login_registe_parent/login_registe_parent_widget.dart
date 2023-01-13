import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/authication/bloc/authentication_bloc.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/pages/login/bloc/login_bloc.dart';
import 'package:tutor/pages/parent_pages/login_registe_parent/log_reg_form.dart';
import 'package:flutter/material.dart';
import 'package:tutor/utils/repository/user_repository.dart';

class LoginRegisteParentWidget extends StatelessWidget {
  final UserRepository userRepository;
  const LoginRegisteParentWidget({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: userRepository,
            );
          },
          child: Log_reg_form()),
    );
  }
}
