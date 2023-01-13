import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tutor/pages/parent_pages/lessons_page/bloc/lessons_bloc.dart';
import 'package:tutor/widgets/add_button.dart';
import 'package:tutor/widgets/lessons_widgets/sub_title.dart';
import 'package:tutor/widgets/lessons_widgets/lessons_title.dart';
import 'package:tutor/widgets/titles/top_title.dart';

class LessonsForm extends StatefulWidget {
  const LessonsForm({Key? key}) : super(key: key);

  @override
  State<LessonsForm> createState() => _LessonsFormState();
}

class _LessonsFormState extends State<LessonsForm>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 5);
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
        _ChildSelecton(tabController: _tabController)
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
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitle(controller: _tabController),
          LessonsTitle(controller: _tabController),
          GradeBody(controller: _tabController),
        ],
      ),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitle(
              controller: _tabController,
              backArrowTap: () => _tabController.index = 0),
          LessonsTitle(controller: _tabController),
          Subtitle(text: 'Select Lessons'),
          SubjectsBody(controller: _tabController),
        ],
      ),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitle(
              controller: _tabController,
              backArrowTap: () => _tabController.index = 1),
          LessonsTitle(controller: _tabController),
          Subtitle(text: 'Select Section'),
          SectionsBody(
            controller: _tabController,
          ),
        ],
      ),
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
          TopTitle(
              controller: _tabController,
              backArrowTap: () => _tabController.index = 2),
          LessonsTitle(controller: _tabController),
          SubSectionBody(controller: _tabController),
        ],
      ),
    );
  }
}

class _ChildSelecton extends StatelessWidget {
  const _ChildSelecton({
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
          TopTitle(
              controller: _tabController,
              backArrowTap: () => _tabController.index = 3),
          LessonsTitle(controller: _tabController),
          SelectChildBody(
            controller: _tabController,
          ),
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
    return BlocBuilder<LessonsBloc, LessonsState>(
      builder: (context, state) {
        final image = state.listOfSubSections?.sectionImage.url ?? '';
        final title = state.listOfSubSections?.title ?? '';
        final creationYear = state.listOfSubSections?.dateOfCreation.year ?? '';
        final creationMonth =
            state.listOfSubSections?.dateOfCreation.month ?? '';
        final creationDay = state.listOfSubSections?.dateOfCreation.day ?? '';
        final completed = state.listOfSubSections?.completed ?? '';
        final bestScore = state.listOfSubSections?.bestScore.toString() ?? '';
        final bestScoreYear = state.listOfSubSections?.bestScoreDate.year ?? '';
        final bestScoreMonth =
            state.listOfSubSections?.bestScoreDate.month ?? '';
        final bestScoreDay = state.listOfSubSections?.bestScoreDate.day ?? '';
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(0, 30, 0, 6),
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
                      bestScore.length != 0
                          ? bestScore.replaceRange(2, null, '') +
                              'min ' +
                              '$bestScoreDay.$bestScoreMonth.$bestScoreYear'
                          : '',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: REdgeInsetsDirectional.fromSTEB(36, 36, 36, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Available for: ',
                      style: FlutterFlowTheme.of(context).title3.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).title3Family,
                            fontSize: 25.sp,
                          ),
                    ),
                    AddButton(
                      controller: controller,
                      onPressed: () {
                        context.read<LessonsBloc>().add(LoadChildren());
                        controller.index = 4;
                      },
                    ),
                  ],
                ),
              ),
              _AsignChildren(),
              Padding(
                padding: REdgeInsetsDirectional.fromSTEB(36, 0, 36, 14),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Now performing:',
                      style: FlutterFlowTheme.of(context).title3.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).title3Family,
                            fontSize: 25.sp,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: REdgeInsetsDirectional.fromSTEB(36, 0, 36, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: REdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Text(
                        'Compleated:',
                        style: FlutterFlowTheme.of(context).title3.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).title3Family,
                              fontSize: 25.sp,
                            ),
                      ),
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

class _AsignChildren extends StatelessWidget {
  const _AsignChildren({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonsBloc, LessonsState>(
      builder: (context, state) {
        var count =
            state.listOfSubSections?.assignedChildUsersSections.length ?? 0;
        return Container(
          height: 128.h * count,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBtnText,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            primary: false,
            scrollDirection: Axis.vertical,
            itemCount: count,
            itemBuilder: (context, index) {
              var image = state.listOfSubSections?.assignedChildUsersSections
                      .map((e) => e.childImage.url)
                      .toList()[index] ??
                  '';
              var name = state.listOfSubSections?.assignedChildUsersSections
                      .map((e) => e.name)
                      .toList()[index] ??
                  '';
              return Padding(
                padding: REdgeInsetsDirectional.fromSTEB(21, 0, 21, 0),
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
                          imageUrl: image,
                          placeholder: ((context, url) =>
                              Center(child: CircularProgressIndicator())),
                          errorWidget: (context, url, error) => SizedBox(),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          name,
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).title3,
                        ),
                      ),
                    ],
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

class SelectChildBody extends StatelessWidget {
  const SelectChildBody({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonsBloc, LessonsState>(
      builder: (context, state) {
        return SizedBox(
          height: 524.h,
          child: ListView.builder(
            padding: REdgeInsets.only(top: 59),
            primary: false,
            scrollDirection: Axis.vertical,
            itemCount: state.listOfChildren?.length ?? 0,
            itemBuilder: (context, index) {
              var image = state.listOfChildren
                      ?.map((e) => e.childImage.url)
                      .toList()[index] ??
                  '';
              var name =
                  state.listOfChildren?.map((e) => e.name).toList()[index] ??
                      '';
              var childId =
                  state.listOfChildren?.map((e) => e.id).toList()[index] ?? '';
              // var sectionId = state.listOfSections?.children
              //         .map((e) => e.id)
              //         .toList()[index] ??
              // '';
              var sectionId = state.listOfSubSections?.id ?? '';
              return Padding(
                padding: REdgeInsetsDirectional.fromSTEB(21, 0, 21, 0),
                child: InkWell(
                  onTap: () {
                    context.read<LessonsBloc>().add(
                        AsignChild(childId: childId, sectionId: sectionId));
                    context.read<LessonsBloc>().add(LoadSubSections(
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
                            imageUrl: image,
                            placeholder: ((context, url) =>
                                Center(child: CircularProgressIndicator())),
                            errorWidget: (context, url, error) => SizedBox(),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            name,
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

class SubjectsBody extends StatelessWidget {
  final TabController controller;
  const SubjectsBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonsBloc, LessonsState>(
      builder: (context, state) {
        return SizedBox(
          height: 524.h,
          child: ListView.builder(
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
                    context.read<LessonsBloc>().add(LoadSections(
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
    return BlocBuilder<LessonsBloc, LessonsState>(
      builder: (context, state) {
        return SizedBox(
          height: 524.h,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            primary: true,
            itemCount: state.listOfSections?.children.length ?? 0,
            itemBuilder: (context, index) {
              var sectionImageUrl = state.listOfSections?.children
                      .map((e) => e.sectionImage.url)
                      .toList()[index] ??
                  '';
              var sectionName = state.listOfSections?.children
                      .map((e) => e.title)
                      .toList()[index] ??
                  '';
              var sectionId = state.listOfSections?.children
                      .map((e) => e.id)
                      .toList()[index] ??
                  '';
              var sectionPoints = state.listOfSections?.children
                      .map((e) => e.points)
                      .toList()[index] ??
                  0;
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
                    context.read<LessonsBloc>().add(LoadSubSections(
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
    return BlocBuilder<LessonsBloc, LessonsState>(
      buildWhen: (previous, current) =>
          previous.listOfGrades?.length != current.listOfGrades?.length,
      builder: (context, state) {
        context.read<LessonsBloc>().add(LoadGrades());
        return Container(
          margin: REdgeInsetsDirectional.fromSTEB(34, 37, 34, 0),
          height: 570.h,
          child: GridView.builder(
            primary: true,
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
                            .read<LessonsBloc>()
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
