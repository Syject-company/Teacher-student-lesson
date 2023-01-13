import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tutor/app_state.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';

import '../../pages/child_pages/child_rewards_page/bloc/child_rewards_bloc.dart';

class ChildRewardTopTitle extends StatelessWidget {
  final TabController? controller;

  final void Function()? backArrowTap;

  const ChildRewardTopTitle({
    Key? key,
    this.controller,
    this.backArrowTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildRewardsBloc, ChildRewardsState>(
      buildWhen: (previous, current) =>
          previous.childPoints != current.childPoints,
      builder: (context, state) {
        context.read<ChildRewardsBloc>().add(LoadChildPoints());
        return Container(
          width: 428.w,
          height: 180.h,
          decoration: BoxDecoration(
            color: Color(0xFF2BC0EF),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 152.h,
                decoration: BoxDecoration(),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 29.h),
                          Padding(
                            padding:
                                REdgeInsetsDirectional.fromSTEB(33, 0, 0, 0),
                            child: Text(
                              'Hello, ${FFAppState().firstName}!',
                              style: FlutterFlowTheme.of(context)
                                  .title3
                                  .override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding:
                                REdgeInsetsDirectional.fromSTEB(33, 15, 0, 0),
                            child: Text(
                              '${state.childPoints ?? '...'} points',
                              style: FlutterFlowTheme.of(context)
                                  .title2
                                  .override(
                                      fontSize: 40.sp,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: REdgeInsetsDirectional.fromSTEB(2, 30, 13, 0),
                      child: SvgPicture.asset(
                        'assets/images/No_Subscrib.svg',
                        width: 133.w,
                        height: 123.h,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                          width: 0,
                        ),
                      ),
                    ),
                    backArrowTap != null
                        ? BackArrow(
                            tabController: controller,
                            onTap: backArrowTap,
                          )
                        : SizedBox.shrink()
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

class BackArrow extends StatelessWidget {
  final TabController? tabController;
  final void Function()? onTap;
  const BackArrow({
    Key? key,
    this.tabController,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            child: Padding(
              padding: REdgeInsets.fromLTRB(17, 5, 0, 0),
              child: Icon(
                Icons.arrow_back_ios,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 25.h,
              ),
            ),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
