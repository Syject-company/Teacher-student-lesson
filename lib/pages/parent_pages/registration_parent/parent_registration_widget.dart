import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/authication/bloc/authentication_bloc.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/pages/parent_pages/registration_parent/parent_registr_form.dart';
import 'package:tutor/pages/registration/bloc/reg_bloc.dart';
import 'package:tutor/utils/repository/repositories.dart';
import 'package:flutter/material.dart';

class RegistrationWidget extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  RegistrationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: BlocProvider(
          create: (context) => RegistrationBloc(
            userRepository: UserRepository(),
          ),
          child: RegistrForm(),
        ));
  }
}
