import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/pages/child_pages/child_lessons_page/bloc/child_lessons_bloc.dart';

class ChildLessonsTitle extends StatelessWidget {
  final TabController? controller;

  const ChildLessonsTitle({
    Key? key,
    this.controller,
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
        child: BlocBuilder<ChildLessonsBloc, ChildLessonsState>(
          builder: (context, state) {
            String? text = '';
            if (controller?.index == 0) {
              text = 'Select Grade';
            } else if (controller?.index == 1) {
              text = 'Grade ${state.listOfSubjects?.parent.title ?? ""}';
            } else if (controller?.index == 2 ||
                controller?.index == 3 ||
                controller == null) {
              text =
                  '${state.listOfSubjects?.children.map((e) => e.title).toList()[0] ?? "Math"}';
            } else if (controller?.index == 4) {
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
