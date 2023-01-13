import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:tutor/pages/child_pages/child_chores_page/bloc/child_chores_bloc.dart';
import 'package:tutor/pages/child_pages/child_chores_page/child_chores_form.dart';
import 'package:tutor/utils/repository/repositories.dart';

class ChildChoresPageWidget extends StatefulWidget {
  const ChildChoresPageWidget({Key? key}) : super(key: key);

  @override
  _ChildChoresPageWidgetState createState() => _ChildChoresPageWidgetState();
}

class _ChildChoresPageWidgetState extends State<ChildChoresPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: BlocProvider(
        create: (context) => ChildChoresBloc(userRepository: UserRepository()),
        child: ChildChoresForm(),
      ),
    );
  }
}
