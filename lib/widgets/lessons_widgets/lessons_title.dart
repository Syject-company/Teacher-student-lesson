import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/pages/parent_pages/lessons_page/bloc/lessons_bloc.dart';

class LessonsTitle extends StatelessWidget {
  final TabController controller;

  const LessonsTitle({
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
        child: BlocBuilder<LessonsBloc, LessonsState>(
          builder: (context, state) {
            String? text = '';
            if (controller.index == 0) {
              text = 'Select Grade';
            } else if (controller.index == 1) {
              text = 'Grade ${state.listOfSubjects?.parent.title ?? ""}';
            } else if (controller.index == 2 || controller.index == 3) {
              text = '${state.listOfSections?.parent.title ?? ""}';
            } else if (controller.index == 4) {
              text = 'Select Child';
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
