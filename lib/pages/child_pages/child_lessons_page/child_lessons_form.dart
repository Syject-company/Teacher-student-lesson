import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/constants/const_text.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/flutter_flow/flutter_flow_widgets.dart';
import 'package:tutor/pages/child_pages/child_lessons_page/bloc/child_lessons_bloc.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tutor/pages/quiz/quiz.dart';
import 'package:tutor/widgets/lessons_widgets/child_lessons_title.dart';

import 'package:tutor/widgets/titles/child_top_title.dart';
import 'package:tutor/widgets/lessons_widgets/sub_title.dart';
import 'package:tutor/widgets/lessons_widgets/lessons_title.dart';

class ChildLessonsForm extends StatefulWidget {
  const ChildLessonsForm({Key? key}) : super(key: key);

  @override
  State<ChildLessonsForm> createState() => _ChildLessonsFormState();
}

class _ChildLessonsFormState extends State<ChildLessonsForm>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: [
        _Grades(tabController: _tabController),
        _Subjects(tabController: _tabController),
        _Sections(tabController: _tabController),
        _SubSections(tabController: _tabController),
      ],
    );
  }
}

class _Grades extends StatelessWidget {
  const _Grades({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChildTopTitle(
          controller: _tabController,
          text1: ConstText.text1Lessons,
          text2: ConstText.text2Lessons,
        ),
        Expanded(
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ChildLessonsTitle(controller: _tabController),
                  GradeBody(controller: _tabController),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Subjects extends StatelessWidget {
  const _Subjects({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChildTopTitle(
            controller: _tabController,
            text1: ConstText.text1Lessons,
            text2: ConstText.text2Lessons,
            backArrowTap: () => _tabController.index = 0),
        Expanded(
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ChildLessonsTitle(controller: _tabController),
                  Subtitle(text: 'Select Lessons'),
                  SubjectsBody(controller: _tabController),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Sections extends StatelessWidget {
  const _Sections({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChildTopTitle(
            controller: _tabController,
            text1: ConstText.text1Lessons,
            text2: ConstText.text2Lessons,
            backArrowTap: () => _tabController.index = 1),
        Expanded(
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ChildLessonsTitle(controller: _tabController),
                  Subtitle(text: 'Select Section'),
                  SectionsBody(controller: _tabController),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SubSections extends StatelessWidget {
  const _SubSections({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ChildTopTitle(
              controller: _tabController,
              text1: ConstText.text1Lessons,
              text2: ConstText.text2Lessons,
              backArrowTap: () => _tabController.index = 2),
          ChildLessonsTitle(controller: _tabController),
          SubSectionBody(controller: _tabController),
          ChildButton(controller: _tabController)
        ],
      ),
    );
  }
}

class SubSectionBody extends StatelessWidget {
  const SubSectionBody({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildLessonsBloc, ChildLessonsState>(
      builder: (context, state) {
        final image = state.listOfSubSections?.sectionImage.url ?? '';
        final title = state.listOfSubSections?.title ?? '';
        final creationYear = state.listOfSubSections?.dateOfCreation.year ?? '';
        final creationMonth =
            state.listOfSubSections?.dateOfCreation.month ?? '';
        final creationDay = state.listOfSubSections?.dateOfCreation.day ?? '';
        final completed = state.listOfSubSections?.completed ?? '';
        final bestScore =
            state.listOfSubSections?.bestScore['milliseconds'] ?? '';
        final bestScoreDate = state.listOfSubSections?.bestScoreDate ?? '';
        final bestScoreYear = state.listOfSubSections?.bestScoreDate.year ?? '';
        final bestScoreMonth =
            state.listOfSubSections?.bestScoreDate.month ?? '';
        final bestScoreDay = state.listOfSubSections?.bestScoreDate.day ?? '';
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(0, 30, 0, 116),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CachedNetworkImage(
                height: 153.h,
                imageUrl: image,
                placeholder: ((context, url) =>
                    Center(child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => SizedBox(),
                fit: BoxFit.contain,
              ),
              Padding(
                padding: REdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                child: Text(
                  title,
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
                      'Questions',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                    Text(
                      '20',
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
                      '$creationDay.$creationMonth.$creationYear',
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
                      'Completed',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                    Text(
                      '$completed times',
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
                      'Best Score',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                    Text(
                      bestScore.toString() +
                          'min ' +
                          '$bestScoreDay.$bestScoreMonth.$bestScoreYear',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChildButton extends StatelessWidget {
  final TabController controller;

  ChildButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildLessonsBloc, ChildLessonsState>(
      builder: (context, state) {
        return FFButtonWidget(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizWidget(
                  state: state,
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
      },
    );
  }
}

class SubjectsBody extends StatelessWidget {
  final TabController controller;
  const SubjectsBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildLessonsBloc, ChildLessonsState>(
      builder: (context, state) {
        return SizedBox(
          height: 513.h,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            primary: true,
            itemCount: state.listOfSubjects?.children.length ?? 0,
            itemBuilder: (context, index) {
              final String subjectImageUrl = state.listOfSubjects?.children
                      .map((e) => e.subjectImage.url)
                      .toList()[index] ??
                  '';
              final String subjectName = state.listOfSubjects?.children
                      .map((e) => e.title)
                      .toList()[index] ??
                  '';
              final String subjectId = state.listOfSubjects?.children
                      .map((e) => e.id)
                      .toList()[index] ??
                  '';
              final String gradeId = state.listOfSubjects?.parent.id ?? '';
              return Padding(
                padding: REdgeInsetsDirectional.fromSTEB(21, 0, 21, 0),
                child: InkWell(
                  onTap: () {
                    context.read<ChildLessonsBloc>().add(LoadSections(
                          gradeId: gradeId,
                          subjectId: subjectId,
                        ));
                    controller.index = 2;
                  },
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Color(0xFFF5F6FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              REdgeInsetsDirectional.fromSTEB(23, 14, 23, 14),
                          child: CachedNetworkImage(
                            height: 77.h,
                            imageUrl: subjectImageUrl,
                            placeholder: ((context, url) =>
                                Center(child: CircularProgressIndicator())),
                            errorWidget: (context, url, error) =>
                                Center(child: CircularProgressIndicator()),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            subjectName,
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context).title3,
                          ),
                        ),
                        Padding(
                          padding: REdgeInsetsDirectional.fromSTEB(0, 8, 23, 8),
                          child: Icon(
                            Icons.navigate_next_outlined,
                            size: 40.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class SectionsBody extends StatelessWidget {
  final TabController controller;
  const SectionsBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildLessonsBloc, ChildLessonsState>(
      builder: (context, state) {
        return SizedBox(
          height: 513.h,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            primary: true,
            itemCount: state.listOfSections?.length ?? 0,
            itemBuilder: (context, index) {
              var sectionImageUrl = state.listOfSections!
                  .map((e) => e.sectionImage.url)
                  .toList()[index];
              var sectionName =
                  state.listOfSections!.map((e) => e.title).toList()[index];
              var sectionId =
                  state.listOfSections!.map((e) => e.id).toList()[index];
              var sectionPoints =
                  state.listOfSections!.map((e) => e.points).toList()[index];
              var color1 = Colors.transparent;
              var color2 = Colors.transparent;
              if (sectionPoints < 70) {
                color1 = const Color.fromRGBO(211, 114, 24, 1);
                color2 = const Color.fromRGBO(226, 149, 78, 1);
              } else if (sectionPoints >= 70 && sectionPoints < 100) {
                color1 = const Color.fromRGBO(123, 123, 123, 1);
                color2 = const Color.fromRGBO(199, 199, 199, 1);
              } else if (sectionPoints == 100) {
                color1 = const Color.fromRGBO(232, 175, 46, 1);
                color2 = const Color.fromRGBO(249, 202, 53, 1);
              }
              return Padding(
                padding: REdgeInsetsDirectional.fromSTEB(21, 0, 21, 0),
                child: InkWell(
                  onTap: () {
                    print(sectionId);
                    context.read<ChildLessonsBloc>().add(LoadSubSections(
                          sectionId: sectionId,
                        ));
                    controller.index = 3;
                  },
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Color(0xFFF5F6FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              REdgeInsetsDirectional.fromSTEB(23, 14, 23, 14),
                          child: CachedNetworkImage(
                            height: 77.h,
                            imageUrl: sectionImageUrl,
                            placeholder: ((context, url) =>
                                Center(child: CircularProgressIndicator())),
                            errorWidget: (context, url, error) => SizedBox(),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            sectionName,
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context).title3,
                          ),
                        ),
                        Padding(
                          padding: REdgeInsetsDirectional.fromSTEB(0, 8, 23, 8),
                          child: Stack(
                            children: [
                              Container(
                                  width: 91.w,
                                  height: 91.h,
                                  decoration: BoxDecoration(
                                    color: color1,
                                    shape: BoxShape.circle,
                                  )),
                              Positioned(
                                left: (91.w - 74.w) / 2,
                                top: (91.h - 74.h) / 2,
                                child: Container(
                                    width: 74.w,
                                    height: 74.h,
                                    child: Padding(
                                      padding: REdgeInsets.only(top: 8.0),
                                      child: Column(
                                        children: [
                                          Text('$sectionPoints',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .title3
                                                  .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title3Family,
                                                      fontSize: 25.sp,
                                                      color: Colors.white)),
                                          Text('POINTS',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .title3
                                                  .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title3Family,
                                                      fontSize: 16.sp,
                                                      color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: color2,
                                      shape: BoxShape.circle,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class GradeBody extends StatelessWidget {
  final TabController controller;

  const GradeBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildLessonsBloc, ChildLessonsState>(
      buildWhen: (previous, current) =>
          previous.listOfGrades?.length != current.listOfGrades?.length,
      builder: (context, state) {
        context.read<ChildLessonsBloc>().add(LoadGrades());
        return Container(
          margin: REdgeInsetsDirectional.fromSTEB(34, 37, 34, 0),
          height: 535.h,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 30,
              mainAxisSpacing: 0,
              childAspectRatio: 0.75,
            ),
            itemCount: state.listOfGrades?.length ?? 1,
            itemBuilder: (context, index) {
              final String gradeId =
                  state.listOfGrades?.map((e) => e.id).toList()[index] ?? '';
              final Object gradeTitile =
                  state.listOfGrades?.map((e) => e.title).toList()[index] ?? '';
              final String gradeImage = state.listOfGrades
                      ?.map((e) => e.gradeImage.url)
                      .toList()[index] ??
                  '';
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        context
                            .read<ChildLessonsBloc>()
                            .add(LoadSubjects(gradeId: gradeId));
                        controller.index = 1;
                      },
                      child: CachedNetworkImage(
                        height: 80.h,
                        imageUrl: gradeImage,
                        placeholder: ((context, url) =>
                            Center(child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) => SizedBox(),
                        fit: BoxFit.contain,
                      )),
                  Padding(
                    padding: REdgeInsets.only(top: 10),
                    child: Text(
                      'Grade $gradeTitile',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
