import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/pages/quiz/quiz_timer.dart';

class QuizTopTitle extends StatelessWidget {
  final TabController? controller;

  final void Function()? backArrowTap;

  const QuizTopTitle({Key? key, this.controller, this.backArrowTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2BC0EF),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: REdgeInsetsDirectional.fromSTEB(50, 52, 0, 0),
                  child: CountUpTimer(),
                ),
              ),
              Padding(
                padding: REdgeInsetsDirectional.fromSTEB(0, 42, 80, 0),
                child: SvgPicture.asset(
                  'assets/images/no_idea.svg',
                  height: 75.h,
                  width: 102.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuizSectionTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsetsDirectional.fromSTEB(35, 15, 0, 0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Text(
        'Available tasks',
        style: FlutterFlowTheme.of(context).title2,
      ),
    );
  }
}

class QuizQuestionNumber extends StatelessWidget {
  final String text;

  const QuizQuestionNumber({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsetsDirectional.fromSTEB(35, 20, 0, 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Text(
        text,
        style: FlutterFlowTheme.of(context).subtitle2.override(
              fontFamily: 'Montserrat',
              fontSize: 25.sp,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
