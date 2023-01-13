import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/authication/bloc/authentication_bloc.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/pages/parent_pages/setting_page/bloc/setting_bloc.dart';
import 'package:tutor/pages/parent_pages/setting_page/setting_form.dart';
import 'package:tutor/pages/registration/bloc/reg_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tutor/utils/repository/user_repository.dart';

class SettingPageWidget extends StatefulWidget {
  final int? wentToindex;
  final bool isChild;
  const SettingPageWidget({Key? key, this.wentToindex, required this.isChild})
      : super(key: key);

  @override
  _SettingPageWidgetState createState() => _SettingPageWidgetState();
}

class _SettingPageWidgetState extends State<SettingPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RegistrationBloc(
              userRepository: userRepository,
            ),
          ),
          BlocProvider(
            create: (context) => SettingBloc(userRepository: userRepository),
          ),
        ],
        child: SettingPageForm(
            wentToindex: widget.wentToindex, isChild: widget.isChild),
      ),
    );
  }
}
