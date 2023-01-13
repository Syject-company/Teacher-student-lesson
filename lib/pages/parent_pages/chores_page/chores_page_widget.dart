import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:tutor/pages/parent_pages/chores_page/bloc/chores_bloc.dart';
import 'package:tutor/pages/parent_pages/chores_page/chores_form.dart';
import 'package:tutor/utils/repository/repositories.dart';

class ChoresPageWidget extends StatefulWidget {
  const ChoresPageWidget({Key? key}) : super(key: key);

  @override
  _ChoresPageWidgetState createState() => _ChoresPageWidgetState();
}

class _ChoresPageWidgetState extends State<ChoresPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: BlocProvider(
        create: (context) => ChoresBloc(userRepository: UserRepository()),
        child: ChoresForm(),
      ),
    );
  }
}
