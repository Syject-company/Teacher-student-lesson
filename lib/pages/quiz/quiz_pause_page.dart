import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tutor/app_state.dart';
import 'package:tutor/constants/const_text.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/flutter_flow/flutter_flow_widgets.dart';
import 'package:tutor/navigation/child_nav_page.dart';
import 'package:tutor/pages/child_pages/child_lessons_page/bloc/child_lessons_bloc.dart';
import 'package:tutor/pages/quiz/quiz.dart';
import 'package:tutor/utils/model/compleated_sections/compleated_sections.dart';
import 'package:tutor/utils/model/reward/test_results.dart';
import 'package:tutor/utils/model/sub_section/child_sub_section.dart';
import 'package:tutor/utils/repository/repositories.dart';
import 'package:tutor/widgets/lessons_widgets/child_lessons_title.dart';
import 'package:tutor/widgets/titles/child_top_title.dart';

class QuizPausePage extends StatelessWidget {
  final ChildLessonsState state;
  final bool isEnd;
  final String correctAnswers;

  final questions;

  final CompletedSections completedSections;
  const QuizPausePage({
    Key? key,
    required this.state,
    required this.correctAnswers,
    required this.questions,
    required this.completedSections,
    this.isEnd = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (questions.length == 1) {
      FFAppState().isLastRound = true;
      print(FFAppState().wrongQuestions.length);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChildTopTitle(
              text1: ConstText.text1Lessons,
              text2: ConstText.text2Lessons,
            ),
            ChildLessonsTitle(),
            QuizPauseBody(correctAnswers: correctAnswers),
            (FFAppState().wrongQuestions.length == 0) &&
                    (FFAppState().isLastRound == true)
                ? SizedBox.shrink()
                : questions.length != 1 && !FFAppState().isLastRound
                    ? NextButton(
                        state: state,
                        completedSections: completedSections,
                        questions: questions,
                      )
                    : !isEnd
                        ? NextButton(
                            state: state,
                            completedSections: completedSections,
                            questions: FFAppState().wrongQuestions,
                          )
                        : SizedBox.shrink(),
            FinishButton(completedSections: completedSections, state: state)
          ],
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final ChildLessonsState state;

  final CompletedSections completedSections;

  final questions;

  NextButton({
    Key? key,
    required this.state,
    required this.completedSections,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: () {
        if (!FFAppState().isLastRound) {
          FFAppState().correctAnswers = completedSections;
          FFAppState().totalWrongAnswers = 20 -
              (FFAppState().correctAnswers.questionOneAnswer.length +
                  FFAppState().correctAnswers.questionOneFalseAnswer.length +
                  FFAppState().correctAnswers.questionPictureOneAnswer.length +
                  FFAppState().correctAnswers.questionTrueFalse.length);
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizWidget(
              state: state,
              completedSections: completedSections,
              questions: questions,
            ),
          ),
        );
      },
      text: 'Start',
      options: FFButtonOptions(
        width: 360.w,
        height: 60.h,
        color: Color(0xFF2BC0EF),
        textStyle: FlutterFlowTheme.of(context).subtitle2.override(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
    );
    // },
    // );
  }
}

class FinishButton extends StatelessWidget {
  FinishButton({
    Key? key,
    required this.completedSections,
    required this.state,
  }) : super(key: key);
  final CompletedSections completedSections;
  final ChildLessonsState state;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChildLessonsBloc(userRepository: UserRepository()),
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 14.0),
        child: FFButtonWidget(
          onPressed: () {
            FFAppState().isLastRound = false;
            FFAppState().wrongQuestions = [];
            FFAppState().totalWrongAnswers = 0;
            completedSections.questionOneAnswer.toList().forEach(
                (e) => FFAppState().correctAnswers.questionOneAnswer.add(e));
            completedSections.questionOneFalseAnswer.toList().forEach(
                (e) => FFAppState().correctAnswers.questionOneAnswer.add(e));
            completedSections.questionPictureOneAnswer.toList().forEach((e) =>
                FFAppState().correctAnswers.questionOneFalseAnswer.add(e));
            completedSections.questionTrueFalse.toList().forEach((e) =>
                FFAppState().correctAnswers.questionPictureOneAnswer.add(e));

            FFAppState().correctAnswers.sectionId =
                state.listOfSubSections?.id ?? '';

            context.read<ChildLessonsBloc>().add(SendResults(
                result: Result(
                    sectionId: FFAppState().correctAnswers.sectionId,
                    questionOneAnswer:
                        FFAppState().correctAnswers.questionOneAnswer,
                    questionOneFalseAnswer:
                        FFAppState().correctAnswers.questionOneFalseAnswer,
                    questionPictureOneAnswer:
                        FFAppState().correctAnswers.questionPictureOneAnswer,
                    questionTrueFalse:
                        FFAppState().correctAnswers.questionTrueFalse)));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChildNavBarPage(initialPage: 'LessonsPage'),
              ),
            );
          },
          text: 'Finish',
          options: FFButtonOptions(
            width: 360.w,
            height: 60.h,
            color: Color.fromRGBO(154, 229, 253, 1),
            textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}

class QuizPauseBody extends StatelessWidget {
  final String correctAnswers;

  const QuizPauseBody({
    Key? key,
    required this.correctAnswers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<ChildLessonsBloc, ChildLessonsState>(
    //   builder: (context, state) {
    //     final image = state.listOfSubSections?.sectionImage.url ?? '';
    //     final title = state.listOfSubSections?.title ?? '';
    //     final creationYear = state.listOfSubSections?.dateOfCreation.year ?? '';
    //     final creationMonth =
    //         state.listOfSubSections?.dateOfCreation.month ?? '';
    //     final creationDay = state.listOfSubSections?.dateOfCreation.day ?? '';
    //     final completed = state.listOfSubSections?.completed ?? '';
    //     final bestScore = state.listOfSubSections?.bestScore.toString() ?? '';
    //     final bestScoreDate = state.listOfSubSections?.bestScoreDate ?? '';
    //     final bestScoreYear = state.listOfSubSections?.bestScoreDate.year ?? '';
    //     final bestScoreMonth =
    //         state.listOfSubSections?.bestScoreDate.month ?? '';
    //     final bestScoreDay = state.listOfSubSections?.bestScoreDate.day ?? '';
    return Padding(
      padding: REdgeInsetsDirectional.fromSTEB(0, 30, 0, 116),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            'assets/images/pause_quiz.svg',
            height: 182.h,
            fit: BoxFit.scaleDown,
          ),
          Padding(
            padding: REdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
            child: Text(
              'Numbers to 100',
              style: FlutterFlowTheme.of(context).title3.override(
                    fontFamily: FlutterFlowTheme.of(context).title3Family,
                    fontSize: 25.sp,
                  ),
            ),
          ),
          Padding(
            padding: REdgeInsetsDirectional.fromSTEB(36, 0, 36, 14),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Correct answers',
                  style: FlutterFlowTheme.of(context).bodyText2,
                ),
                Text(
                  correctAnswers,
                  style: FlutterFlowTheme.of(context).bodyText2,
                ),
              ],
            ),
          ),
          Padding(
            padding: REdgeInsetsDirectional.fromSTEB(36, 0, 36, 14),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date of creation',
                  style: FlutterFlowTheme.of(context).bodyText2,
                ),
                Text(
                  // '$creationDay.$creationMonth.$creationYear',
                  '12.01.2022',
                  style: FlutterFlowTheme.of(context).bodyText2,
                ),
              ],
            ),
          ),
          Padding(
            padding: REdgeInsetsDirectional.fromSTEB(36, 0, 36, 14),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Execution time',
                  style: FlutterFlowTheme.of(context).bodyText2,
                ),
                Text(
                  '3 min',
                  style: FlutterFlowTheme.of(context).bodyText2,
                ),
              ],
            ),
          ),
          Padding(
            padding: REdgeInsetsDirectional.fromSTEB(36, 0, 36, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Difficulty level',
                  style: FlutterFlowTheme.of(context).bodyText2,
                ),
                Text(
                  'Easy',
                  style: FlutterFlowTheme.of(context).bodyText2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
    //   },
    // );
  }
}
