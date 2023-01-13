import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';

class Subtitle extends StatelessWidget {
  final String text;

  const Subtitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.fromSTEB(35, 15, 0, 0),
      child: Container(
        width: double.infinity,
        height: 44.h,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Text(
          text,
          style: FlutterFlowTheme.of(context).subtitle1,
        ),
      ),
    );
  }
}
