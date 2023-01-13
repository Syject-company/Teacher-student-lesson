import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';

class BackTitle extends StatelessWidget {
  final TabController? tabController;
  final void Function() onTap;
  final String text;
  BackTitle({
    Key? key,
    this.tabController,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: REdgeInsetsDirectional.fromSTEB(0, 0, 0, 14),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).subtitle1,
        ),
      ),
    );
  }
}
