import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';

class RegTitleText extends StatelessWidget {
  final String text;
  const RegTitleText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: FlutterFlowTheme.of(context).title2,
      ),
    );
  }
}
