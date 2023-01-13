import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tutor/pages/parent_pages/home_page/bloc/home_page_bloc.dart';
import 'package:tutor/widgets/titles/notification_title.dart';
import 'package:tutor/widgets/titles/top_title.dart';

class HomePageForm extends StatelessWidget {
  const HomePageForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopTitle(),
        Expanded(
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NotificationsTitle(),
                  ParentNotificationBody(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ParentNotificationBody extends StatelessWidget {
  const ParentNotificationBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      buildWhen: (previous, current) =>
          previous.parentNotifications?.length !=
          current.parentNotifications?.length,
      builder: (context, state) {
        context.read<HomePageBloc>().add(LoadParentNotifications());
        return Container(
          margin: REdgeInsets.only(top: 29),
          height: state.parentNotifications?.length == 0 ? 0 : 505.h,
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: state.parentNotifications?.length ?? 0,
            itemBuilder: (context, index) {
              final notificationName = state.parentNotifications
                      ?.map((e) => e.title)
                      .toList()[index] ??
                  '';
              final notificationPoints = state.parentNotifications
                      ?.map((e) => e.points)
                      .toList()[index] ??
                  0;
              final childImage = state.parentNotifications
                      ?.map((e) => e.childUser.childImage.url)
                      .toList()[index] ??
                  '';
              final childName = state.parentNotifications
                      ?.map((e) => e.childUser.name)
                      .toList()[index] ??
                  '';

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
                        padding:
                            REdgeInsetsDirectional.fromSTEB(23, 14, 23, 14),
                        child: CachedNetworkImage(
                          height: 77.h,
                          imageUrl: childImage,
                          placeholder: ((context, url) =>
                              Center(child: CircularProgressIndicator())),
                          errorWidget: (context, url, error) => SizedBox(),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: REdgeInsets.only(left: 37),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                childName,
                                style: FlutterFlowTheme.of(context).title3,
                              ),
                              10.verticalSpace,
                              Text(
                                notificationName,
                                style: FlutterFlowTheme.of(context)
                                    .title3
                                    .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title3Family,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.sp,
                                        color: Colors.green),
                              ),
                            ],
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
                                      : '+$notificationPoints',
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
              );
            },
          ),
        );
      },
    );
  }
}
