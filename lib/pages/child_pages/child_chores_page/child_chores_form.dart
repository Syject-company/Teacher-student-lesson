import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/flutter_flow/flutter_flow_widgets.dart';
import 'package:tutor/pages/child_pages/child_chores_page/bloc/child_chores_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tutor/widgets/chores_widgets/child_chores_title.dart';
import 'package:tutor/widgets/titles/child_top_title.dart';
import 'package:tutor/widgets/titles/top_title.dart';

class ChildChoresForm extends StatefulWidget {
  const ChildChoresForm({Key? key}) : super(key: key);

  @override
  State<ChildChoresForm> createState() => _ChildChoresFormState();
}

class _ChildChoresFormState extends State<ChildChoresForm>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
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
        Chores(tabController: _tabController),
        Chore(tabController: _tabController),
      ],
    );
  }
}

class Chores extends StatelessWidget {
  const Chores({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChildTopTitle(controller: _tabController),
        Expanded(
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ChildChoresTitle(controller: _tabController),
                  ChildChoresBody(controller: _tabController),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Chore extends StatelessWidget {
  const Chore({
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
          ChildChoresTitle(controller: _tabController),
          ChoreBody(controller: _tabController),
          ChildButton(controller: _tabController)
        ],
      ),
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
    return BlocBuilder<ChildChoresBloc, ChildChoresState>(
      builder: (context, state) {
        return FFButtonWidget(
          onPressed: () {
            BlocProvider.of<ChildChoresBloc>(context)
                .add(CompleteChore(choreId: state.choreData?.id ?? ''));
            controller.index = 0;
          },
          text: 'Finish',
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

class ChoreBody extends StatelessWidget {
  final TabController controller;
  const ChoreBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildChoresBloc, ChildChoresState>(
      buildWhen: (previous, current) =>
          previous.choreData?.id != current.choreData?.id,
      builder: (context, state) {
        final image = state.choreData?.choreImage.url ?? '';
        final title = state.choreData?.title ?? '';
        final description = state.choreData?.description ?? '';
        final chorePrice = state.choreData?.price ?? '';
        final time =
            '${state.choreData?.time.hour}:${state.choreData?.time.minute}';
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(0, 30, 0, 6),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CircleAvatar(
                radius: 100.h,
                backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                child: Badge(
                  badgeColor: Color.fromRGBO(122, 186, 140, 1),
                  position: BadgePosition.bottomEnd(bottom: 0, end: 0),
                  badgeContent: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '+$chorePrice',
                      style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: FlutterFlowTheme.of(context).title3Family,
                          fontSize: 17.sp,
                          color: Colors.white),
                    ),
                  ),
                  child: CachedNetworkImage(
                    height: 150.h,
                    imageUrl: image,
                    placeholder: ((context, url) =>
                        Center(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) => SizedBox(),
                    fit: BoxFit.fitWidth,
                  ),
                ),
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
                padding: REdgeInsetsDirectional.fromSTEB(88, 0, 88, 0),
                child: Container(
                  child: Text(
                    '$description',
                    maxLines: 3,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyText2,
                  ),
                ),
              ),
              Padding(
                padding: REdgeInsetsDirectional.fromSTEB(68, 30, 68, 160.h),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Time',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: FlutterFlowTheme.of(context).title3Family,
                          color: Color.fromRGBO(49, 49, 49, 1),
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      time,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: FlutterFlowTheme.of(context).title3Family,
                          color: Color.fromRGBO(49, 49, 49, 1),
                          fontWeight: FontWeight.w500),
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

class ChildChoresBody extends StatelessWidget {
  final TabController controller;
  const ChildChoresBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildChoresBloc, ChildChoresState>(
      buildWhen: (previous, current) =>
          previous.listOfChores?.length != current.listOfChores?.length,
      builder: (context, state) {
        context.read<ChildChoresBloc>().add(LoadChildChores());
        return Column(
          children: [
            Padding(
              padding: REdgeInsetsDirectional.fromSTEB(36, 20, 0, 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Active:',
                  style: FlutterFlowTheme.of(context)
                      .title3
                      .override(fontFamily: 'Montserrat', fontSize: 25.sp),
                ),
              ),
            ),
            SizedBox(
              height: 505.h,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.listOfChores?.length ?? 0,
                itemBuilder: (context, index) {
                  final choreImageUrl = state.listOfChores
                          ?.map((e) => e.choreImage.url)
                          .toList()[index] ??
                      '';
                  final choreName =
                      state.listOfChores?.map((e) => e.title).toList()[index] ??
                          '';
                  final choreId =
                      state.listOfChores?.map((e) => e.id).toList()[index] ??
                          '';
                  final chorePrice =
                      state.listOfChores?.map((e) => e.price).toList()[index] ??
                          0;
                  final color1 = const Color.fromRGBO(122, 186, 140, 1);

                  return Padding(
                    padding: REdgeInsetsDirectional.fromSTEB(21, 0, 21, 0),
                    child: InkWell(
                      onTap: () {
                        context
                            .read<ChildChoresBloc>()
                            .add(LoadChore(choreId: choreId));
                        controller.index = 1;
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
                              padding: REdgeInsetsDirectional.fromSTEB(
                                  23, 14, 23, 14),
                              child: CachedNetworkImage(
                                height: 77.h,
                                imageUrl: choreImageUrl,
                                placeholder: ((context, url) =>
                                    Center(child: CircularProgressIndicator())),
                                errorWidget: (context, url, error) =>
                                    SizedBox(),
                                fit: BoxFit.contain,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: REdgeInsets.only(left: 37),
                                child: Text(
                                  choreName,
                                  style: FlutterFlowTheme.of(context).title3,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  REdgeInsetsDirectional.fromSTEB(0, 8, 23, 8),
                              child: Container(
                                  child: Center(
                                    child: Text('+$chorePrice',
                                        style: FlutterFlowTheme.of(context)
                                            .title3
                                            .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .title3Family,
                                                fontSize: 25.sp,
                                                color: Colors.white)),
                                  ),
                                  width: 91.w,
                                  height: 91.h,
                                  decoration: BoxDecoration(
                                    color: color1,
                                    shape: BoxShape.circle,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
