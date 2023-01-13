import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';

class ChildChoresTitle extends StatelessWidget {
  final TabController? controller;

  const ChildChoresTitle({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? text = '';
    if (controller == null) {
      text = 'Available tasks';
    }
    if (controller?.index == 0) {
      text = 'My Chores';
    } else if (controller?.index == 1) {
      text = 'Chore';
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
