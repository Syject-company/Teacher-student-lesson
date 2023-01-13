import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';

class ChooseAvatarTitle extends StatelessWidget {
  const ChooseAvatarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.fromSTEB(0, 0, 158, 20),
      child: Text(
        'Choose an avatar',
        textAlign: TextAlign.center,
        style: FlutterFlowTheme.of(context).title2,
      ),
    );
  }
}
