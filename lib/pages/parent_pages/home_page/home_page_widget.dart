import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:tutor/pages/parent_pages/home_page/bloc/home_page_bloc.dart';
import 'package:tutor/pages/parent_pages/home_page/home_page_form.dart';
import 'package:tutor/utils/repository/repositories.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: BlocProvider(
        create: (context) => HomePageBloc(userRepository: UserRepository()),
        child: HomePageForm(),
      ),
    );
  }
}
