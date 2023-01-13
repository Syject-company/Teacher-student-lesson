import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';

class ChildRewardsTitle extends StatelessWidget {
  final TabController controller;

  const ChildRewardsTitle({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? text = '';
    if (controller.index == 0) {
      text = 'My Rewards';
    } else if (controller.index == 1) {
      text = 'Avalible';
    } else if (controller.index == 2) {
      text = 'Purchased';
    } else if (controller.index == 3) {
      text = 'Reward';
    } else if (controller.index == 4) {
      text = 'Reward';
    }
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
          padding: REdgeInsetsDirectional.fromSTEB(35, 15, 0, 0),
          child: Text(
            text,
            style: FlutterFlowTheme.of(context).title2,
          )),
    );
  }
}
