import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:tutor/pages/parent_pages/lessons_page/bloc/lessons_bloc.dart';
import 'package:tutor/pages/parent_pages/lessons_page/lessons_form.dart';
import 'package:tutor/utils/repository/repositories.dart';

class LessonsPageWidget extends StatefulWidget {
  const LessonsPageWidget({Key? key}) : super(key: key);

  @override
  _LessonsPageWidgetState createState() => _LessonsPageWidgetState();
}

class _LessonsPageWidgetState extends State<LessonsPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: BlocProvider(
        create: (context) => LessonsBloc(userRepository: UserRepository()),
        child: LessonsForm(),
      ),
    );
  }
}
