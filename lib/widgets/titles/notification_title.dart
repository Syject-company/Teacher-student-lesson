import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';

class NotificationsTitle extends StatelessWidget {
  const NotificationsTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
          padding: REdgeInsetsDirectional.fromSTEB(35, 30, 0, 0),
          child: Text(
            'Notifications',
            style: FlutterFlowTheme.of(context).title2,
          )),
    );
  }
}
