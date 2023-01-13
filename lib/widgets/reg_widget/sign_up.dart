import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/pages/welcome/welcome_widget.dart';
import 'package:tutor/utils/components/bottomsheet_widget.dart';

class SignUp extends StatelessWidget {
  const SignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.fromSTEB(0, 15, 0, 19),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomeWidget(),
            ),
          );
        },
        child: Container(
          width: 360.w,
          height: 60.h,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'New In?',
                style: FlutterFlowTheme.of(context).subtitle1,
              ),
              InkWell(
                onTap: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Color(0xFF868686),
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Container(
                          height: 312.h,
                          width: 428.w,
                          child: BottomsheetWidget(),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  ' Sign UP',
                  style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).subtitle1Family,
                        color: Color(0xFF2BC0EF),
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
