import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';

class TitleText extends StatelessWidget {
  final String text;
  const TitleText({
    Key? key,
    required this.text,
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
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: FlutterFlowTheme.of(context).title2,
        ),
      ),
    );
  }
}
