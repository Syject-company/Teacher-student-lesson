import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tutor/pages/child_pages/child_notifications_page/bloc/child_notifications_bloc.dart';
import 'package:tutor/widgets/chores_widgets/child_chores_title.dart';
import 'package:tutor/widgets/titles/notification_title.dart';
import 'package:tutor/widgets/titles/child_top_title.dart';

class ChildNotificationsForm extends StatelessWidget {
  const ChildNotificationsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            ChildChoresTitle(),
            ChildTasksBody(),
            NotificationsTitle(),
            ChildNotificationBody(),
          ],
        ),
      ),
    );
  }
}

class ChildTasksBody extends StatelessWidget {
  const ChildTasksBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildNotificationsBloc, ChildNotificationsState>(
      buildWhen: (previous, current) =>
          previous.assignedChores?.length != current.assignedChores?.length ||
          previous.assignedSections?.length != current.assignedSections?.length,
      builder: (context, state) {
        context.read<ChildNotificationsBloc>().add(LoadChildNotifications());
        return Container(
          margin: REdgeInsets.only(top: 29),
          // height: state.assignedChores?.length == 0 &&
          //         state.assignedSections?.length == 0
          //     ? 0
          //     : 505.h,
          child: Column(
            children: [
              ListOfChores(state: state),
              ListOfLessons(state: state),
            ],
          ),
        );
      },
    );
  }
}

class ListOfLessons extends StatelessWidget {
  final ChildNotificationsState state;
  const ListOfLessons({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: state.assignedSections?.length ?? 0,
      itemBuilder: (context, index) {
        var sectionImageUrl = state.assignedSections!
            .map((e) => e.sectionImage.url)
            .toList()[index];
        var sectionName =
            state.assignedSections!.map((e) => e.title).toList()[index];

        var sectionPoints =
            state.assignedSections!.map((e) => e.points).toList()[index];
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
                  padding: REdgeInsetsDirectional.fromSTEB(23, 14, 23, 14),
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
                                      style: FlutterFlowTheme.of(context)
                                          .title3
                                          .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .title3Family,
                                              fontSize: 25.sp,
                                              color: Colors.white)),
                                  Text('POINTS',
                                      style: FlutterFlowTheme.of(context)
                                          .title3
                                          .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
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
        );
      },
    );
  }
}

class ListOfChores extends StatelessWidget {
  final ChildNotificationsState state;
  const ListOfChores({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: state.assignedChores?.length ?? 0,
      itemBuilder: (context, index) {
        final choreImageUrl = state.assignedChores
                ?.map((e) => e.choreImage.url)
                .toList()[index] ??
            '';
        final choreName =
            state.assignedChores?.map((e) => e.title).toList()[index] ?? '';
        final chorePrice =
            state.assignedChores?.map((e) => e.price).toList()[index] ?? 0;
        final color1 = const Color.fromRGBO(122, 186, 140, 1);

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
                  padding: REdgeInsetsDirectional.fromSTEB(23, 14, 23, 14),
                  child: CachedNetworkImage(
                    height: 77.h,
                    imageUrl: choreImageUrl,
                    placeholder: ((context, url) =>
                        Center(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) => SizedBox(),
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: REdgeInsets.only(left: 5),
                    child: Text(
                      choreName,
                      style: FlutterFlowTheme.of(context).title3,
                    ),
                  ),
                ),
                Padding(
                  padding: REdgeInsetsDirectional.fromSTEB(0, 8, 23, 8),
                  child: Container(
                      child: Center(
                        child: Text('+$chorePrice',
                            style: FlutterFlowTheme.of(context).title3.override(
                                fontFamily:
                                    FlutterFlowTheme.of(context).title3Family,
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
        );
      },
    );
  }
}

class ChildNotificationBody extends StatelessWidget {
  const ChildNotificationBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildNotificationsBloc, ChildNotificationsState>(
      buildWhen: (previous, current) =>
          previous.notifications?.length != current.notifications?.length,
      builder: (context, state) {
        return Container(
          margin: REdgeInsets.only(top: 29),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: state.notifications?.length ?? 0,
            itemBuilder: (context, index) {
              final notificationName =
                  state.notifications?.map((e) => e.title).toList()[index] ??
                      '';
              final notificationPoints =
                  state.notifications?.map((e) => e.points).toList()[index] ??
                      0;
              final color1 = const Color.fromRGBO(122, 186, 140, 1);
              final color2 = const Color.fromRGBO(249, 202, 53, 1);

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
                      Expanded(
                        child: Padding(
                          padding: REdgeInsets.only(left: 37),
                          child: Text(
                            notificationName,
                            style: FlutterFlowTheme.of(context).title3,
                          ),
                        ),
                      ),
                      Padding(
                        padding: REdgeInsetsDirectional.fromSTEB(0, 8, 23, 8),
                        child: Container(
                            child: Center(
                              child: Text(
                                  notificationPoints == 0
                                      ? 'OK'
                                      : '$notificationPoints',
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
                              color: notificationPoints < 0 ? color2 : color1,
                              shape: BoxShape.circle,
                            )),
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
