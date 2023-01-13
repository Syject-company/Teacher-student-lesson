import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:tutor/pages/child_pages/child_notifications_page/bloc/child_notifications_bloc.dart';
import 'package:tutor/pages/child_pages/child_notifications_page/child_notifications_form.dart';
import 'package:tutor/utils/repository/repositories.dart';
import 'package:tutor/widgets/titles/child_top_title.dart';

class ChildHomePageWidget extends StatefulWidget {
  const ChildHomePageWidget({Key? key}) : super(key: key);

  @override
  _ChildHomePageWidgetState createState() => _ChildHomePageWidgetState();
}

class _ChildHomePageWidgetState extends State<ChildHomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: BlocProvider(
        create: (context) =>
            ChildNotificationsBloc(userRepository: UserRepository()),
        child: Column(
          children: [
            ChildTopTitle(
              text1: 'This is your',
              text2: 'your report',
            ),
            Expanded(child: ChildNotificationsForm()),
          ],
        ),
      ),
    );
  }
}
