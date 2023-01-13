import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/pages/parent_pages/rewards_page/bloc/rewards_bloc.dart';

class RewardsTitle extends StatelessWidget {
  final TabController controller;

  const RewardsTitle({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: REdgeInsetsDirectional.fromSTEB(35, 15, 0, 0),
        child: BlocBuilder<RewardsBloc, RewardsState>(
          builder: (context, state) {
            String? text = '';
            if (controller.index == 0) {
              text = 'Manage Rewards';
            } else if (controller.index == 1) {
              text = 'Reward';
            } else if (controller.index == 2) {
              text = 'Create Reward';
            } else if (controller.index == 3) {
              text = 'Edit Reward';
            } else if (controller.index == 4) {
              text = 'Select Child';
            } else if (controller.index == 5) {
              text = 'Select Picture';
            }
            return Text(
              text,
              style: FlutterFlowTheme.of(context).title2,
            );
          },
        ),
      ),
    );
  }
}
