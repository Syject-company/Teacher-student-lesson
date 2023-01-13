import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:tutor/pages/child_pages/child_rewards_page/bloc/child_rewards_bloc.dart';
import 'package:tutor/pages/child_pages/child_rewards_page/child_rewards_form.dart';
import 'package:tutor/utils/repository/repositories.dart';

class ChildRewardsPageWidget extends StatefulWidget {
  const ChildRewardsPageWidget({Key? key}) : super(key: key);

  @override
  _ChildRewardsPageWidgetState createState() => _ChildRewardsPageWidgetState();
}

class _ChildRewardsPageWidgetState extends State<ChildRewardsPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: BlocProvider(
        create: (context) => ChildRewardsBloc(userRepository: UserRepository()),
        child: ChildRewardsForm(),
      ),
    );
  }
}
