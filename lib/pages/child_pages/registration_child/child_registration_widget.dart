import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/authication/bloc/authentication_bloc.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/pages/registration/bloc/reg_bloc.dart';
import 'package:tutor/pages/child_pages/registration_child/child_registr_form.dart';
import 'package:tutor/utils/repository/repositories.dart';
import 'package:flutter/material.dart';

class ChildRegistrationWidget extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final bool? isAddChild;
  final userRep = UserRepository();
  ChildRegistrationWidget({Key? key, this.isAddChild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => RegistrationBloc(
                userRepository: userRep,
                authenticationBloc:
                    BlocProvider.of<AuthenticationBloc>(context),
              ),
            ),
          ],
          child: ChildRegistrForm(isAddChild: isAddChild),
        ));
  }
}
