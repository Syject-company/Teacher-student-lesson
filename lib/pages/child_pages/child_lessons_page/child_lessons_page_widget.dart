import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:tutor/pages/child_pages/child_lessons_page/bloc/child_lessons_bloc.dart';
import 'package:tutor/pages/child_pages/child_lessons_page/child_lessons_form.dart';
import 'package:tutor/utils/repository/repositories.dart';

class ChildLessonsPageWidget extends StatefulWidget {
  const ChildLessonsPageWidget({Key? key}) : super(key: key);

  @override
  _ChildLessonsPageWidgetState createState() => _ChildLessonsPageWidgetState();
}

class _ChildLessonsPageWidgetState extends State<ChildLessonsPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: BlocProvider(
        create: (context) => ChildLessonsBloc(userRepository: UserRepository()),
        child: ChildLessonsForm(),
      ),
    );
  }
}
