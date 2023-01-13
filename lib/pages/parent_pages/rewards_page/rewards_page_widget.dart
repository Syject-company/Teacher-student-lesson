import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:tutor/pages/parent_pages/rewards_page/bloc/rewards_bloc.dart';
import 'package:tutor/pages/parent_pages/rewards_page/rewards_form.dart';
import 'package:tutor/utils/repository/repositories.dart';

class RewardsPageWidget extends StatefulWidget {
  const RewardsPageWidget({Key? key}) : super(key: key);

  @override
  _RewardsPageWidgetState createState() => _RewardsPageWidgetState();
}

class _RewardsPageWidgetState extends State<RewardsPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: BlocProvider(
        create: (context) => RewardsBloc(userRepository: UserRepository()),
        child: RewardsForm(),
      ),
    );
  }
}
