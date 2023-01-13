import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tutor/pages/child_pages/child_rewards_page/bloc/child_rewards_bloc.dart';
import 'package:tutor/widgets/titles/child_reward_title.dart';
import 'package:tutor/widgets/titles/child_top_title.dart';
import 'package:tutor/widgets/rewards_widgets/child_rewards_title.dart';

class ChildRewardsForm extends StatefulWidget {
  const ChildRewardsForm({Key? key}) : super(key: key);

  @override
  State<ChildRewardsForm> createState() => _ChildRewardsFormState();
}

class _ChildRewardsFormState extends State<ChildRewardsForm>
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
        Rewards(tabController: _tabController),
        ActiveRewardSelecton(tabController: _tabController),
        PurchasedRewardSelecton(tabController: _tabController),
        Reward(tabController: _tabController),
        Reward(tabController: _tabController),
      ],
    );
  }
}

class Rewards extends StatelessWidget {
  const Rewards({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChildRewardTopTitle(controller: _tabController),
        ChildRewardsTitle(controller: _tabController),
        ChildRewardsBody(controller: _tabController),
      ],
    );
  }
}

class Reward extends StatelessWidget {
  const Reward({
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
              text1: 'Treat yourself',
              text2: '',
              controller: _tabController,
              backArrowTap: () => _tabController.index = 0),
          ChildRewardsTitle(controller: _tabController),
          RewardBody(controller: _tabController),
        ],
      ),
    );
  }
}

class ActiveRewardSelecton extends StatelessWidget {
  const ActiveRewardSelecton({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    print('7');
    return Column(
      children: [
        ChildRewardTopTitle(
            controller: _tabController,
            backArrowTap: () => _tabController.index = 0),
        Expanded(
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ChildRewardsTitle(controller: _tabController),
                  ActiveRewardBody(controller: _tabController),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PurchasedRewardSelecton extends StatelessWidget {
  const PurchasedRewardSelecton({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChildRewardTopTitle(
            controller: _tabController,
            backArrowTap: () => _tabController.index = 0),
        Expanded(
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ChildRewardsTitle(controller: _tabController),
                  PurchasedRewardBody(controller: _tabController),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ActiveRewardBody extends StatelessWidget {
  const ActiveRewardBody({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildRewardsBloc, ChildRewardsState>(
      buildWhen: (previous, current) =>
          previous.assignedList?.length != current.assignedList?.length,
      builder: (context, state) {
        return Container(
          margin: REdgeInsetsDirectional.fromSTEB(34, 37, 34, 0),
          height: 524.h,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 30,
              mainAxisSpacing: 0,
              childAspectRatio: 1,
            ),
            itemCount: state.assignedList?.length ?? 0,
            itemBuilder: (context, index) {
              final String rewardId =
                  state.assignedList?.map((e) => e.id).toList()[index] ?? '';
              final String imageUrl = state.assignedList
                      ?.map((e) => e.rewardImage.url)
                      .toList()[index] ??
                  '';
              return InkWell(
                  onTap: () {
                    context
                        .read<ChildRewardsBloc>()
                        .add(LoadChildReward(rewardId: rewardId));
                    controller.index = 1;
                  },
                  child: CachedNetworkImage(
                    height: 80.h,
                    imageUrl: imageUrl,
                    placeholder: ((context, url) =>
                        Center(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) => SizedBox(),
                    fit: BoxFit.contain,
                  ));
            },
          ),
        );
      },
    );
  }
}

class PurchasedRewardBody extends StatelessWidget {
  const PurchasedRewardBody({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildRewardsBloc, ChildRewardsState>(
      buildWhen: (previous, current) =>
          previous.purchasedList?.length != current.purchasedList?.length,
      builder: (context, state) {
        return Container(
          margin: REdgeInsetsDirectional.fromSTEB(34, 37, 34, 0),
          height: 524.h,
          child: GridView.builder(
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 30,
              mainAxisSpacing: 0,
              childAspectRatio: 1,
            ),
            itemCount: state.purchasedList?.length ?? 0,
            itemBuilder: (context, index) {
              final String rewardId =
                  state.purchasedList?.map((e) => e.id).toList()[index] ?? '';
              final String imageUrl = state.purchasedList
                      ?.map((e) => e.rewardImage.url)
                      .toList()[index] ??
                  '';
              return InkWell(
                  onTap: () {
                    context
                        .read<ChildRewardsBloc>()
                        .add(LoadChildReward(rewardId: rewardId));
                    controller.index = 4;
                  },
                  child: CachedNetworkImage(
                    height: 80.h,
                    imageUrl: imageUrl,
                    placeholder: ((context, url) =>
                        Center(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) => SizedBox(),
                    fit: BoxFit.contain,
                  ));
            },
          ),
        );
      },
    );
  }
}

class RewardBody extends StatelessWidget {
  final TabController controller;

  const RewardBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildRewardsBloc, ChildRewardsState>(
      buildWhen: (previous, current) =>
          previous.rewardData?.id != current.rewardData?.id,
      builder: (context, state) {
        final image = state.rewardData?.rewardImage.url ?? '';
        final title = state.rewardData?.title ?? '';
        final creation = state.rewardData?.created ?? '';
        final rewardId = state.rewardData?.id ?? '';
        final description = state.rewardData?.description ?? '';
        final rewardPrice = state.rewardData?.price ?? '';
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
                padding: REdgeInsetsDirectional.fromSTEB(36, 20, 36, 15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price per reward',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                    Text(
                      '$rewardPrice points',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: REdgeInsetsDirectional.fromSTEB(36, 0, 36, 190.h),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date of creation',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                    Text(
                      creation.toString().length != 0
                          ? '$creation'.replaceRange(10, null, '')
                          : '',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                  ],
                ),
              ),
              (controller.index != 4)
                  ? FFButtonWidget(
                      onPressed: () {
                        BlocProvider.of<ChildRewardsBloc>(context)
                            .add(BuyReward(rewardId: rewardId));
                        controller.index = 0;
                      },
                      text: 'Buy',
                      options: FFButtonOptions(
                        width: 360.w,
                        height: 60.h,
                        color: Color(0xFF2BC0EF),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
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
                    )
                  : SizedBox.shrink()
            ],
          ),
        );
      },
    );
  }
}

class ChildRewardsBody extends StatelessWidget {
  final TabController controller;
  const ChildRewardsBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildRewardsBloc, ChildRewardsState>(
      buildWhen: (previous, current) =>
          previous.listOfRewards?.assignedRewards?.length !=
              current.listOfRewards?.assignedRewards?.length ||
          previous.listOfRewards?.purchasedRewards?.length !=
              current.listOfRewards?.purchasedRewards?.length,
      builder: (context, state) {
        context.read<ChildRewardsBloc>().add(LoadChildRewards());
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
            ActiveGallery(controller: controller),
            Padding(
              padding: REdgeInsetsDirectional.fromSTEB(36, 0, 0, 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  child: Row(
                    children: [
                      Text('More',
                          style: FlutterFlowTheme.of(context).bodyText1),
                      Icon(
                        Icons.arrow_forward,
                        size: 17.h,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      )
                    ],
                  ),
                  onTap: () {
                    controller.index = 1;
                    context
                        .read<ChildRewardsBloc>()
                        .add(LoadChildAssignedRewards());
                  },
                ),
              ),
            ),
            Padding(
              padding: REdgeInsetsDirectional.fromSTEB(36, 20, 0, 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Requested:',
                  style: FlutterFlowTheme.of(context)
                      .title3
                      .override(fontFamily: 'Montserrat', fontSize: 25.sp),
                ),
              ),
            ),
            RequestedGallery(controller: controller),
            Padding(
              padding: REdgeInsetsDirectional.fromSTEB(36, 0, 0, 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  child: Row(
                    children: [
                      Text('More',
                          style: FlutterFlowTheme.of(context).bodyText1),
                      Icon(
                        Icons.arrow_forward,
                        size: 17.h,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      )
                    ],
                  ),
                  onTap: () {
                    controller.index = 2;
                    context
                        .read<ChildRewardsBloc>()
                        .add(LoadChildPurchasedRewards());
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ActiveGallery extends StatelessWidget {
  final TabController controller;
  ActiveGallery({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildRewardsBloc, ChildRewardsState>(
        buildWhen: (previous, current) =>
            previous.listOfRewards?.assignedRewards?.length !=
            current.listOfRewards?.assignedRewards?.length,
        builder: (context, state) {
          return Container(
              height: 80.h,
              width: 320.w,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var id = state.listOfRewards?.assignedRewards
                          ?.map((e) => e.id)
                          .toList()[index] ??
                      '';
                  var photo = state.listOfRewards?.assignedRewards
                          ?.map((e) => e.rewardImage.url)
                          .toList()[index] ??
                      '';
                  return InkWell(
                    onTap: () {
                      controller.index = 3;

                      context
                          .read<ChildRewardsBloc>()
                          .add(LoadChildReward(rewardId: id));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        padding: REdgeInsets.all(3),
                        height: 48.h,
                        width: 70.w,
                        color: Color.fromRGBO(217, 217, 217, 1),
                        child: CachedNetworkImage(
                          imageUrl: photo.toString(),
                          placeholder: ((context, url) =>
                              CircularProgressIndicator()),
                          errorWidget: (context, url, error) => SizedBox(),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: state.listOfRewards?.assignedRewards?.length ?? 3,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 40.w);
                },
              ));
        });
  }
}

class RequestedGallery extends StatelessWidget {
  final TabController controller;
  RequestedGallery({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildRewardsBloc, ChildRewardsState>(
        buildWhen: (previous, current) =>
            previous.listOfRewards?.purchasedRewards?.length !=
            current.listOfRewards?.purchasedRewards?.length,
        builder: (context, state) {
          return Container(
              height: 80.h,
              width: 320.w,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var id = state.listOfRewards?.purchasedRewards
                          ?.map((e) => e.id)
                          .toList()[index] ??
                      '';
                  var photo = state.listOfRewards?.purchasedRewards
                          ?.map((e) => e.rewardImage.url)
                          .toList()[index] ??
                      '';
                  return InkWell(
                    onTap: () {
                      controller.index = 4;

                      context
                          .read<ChildRewardsBloc>()
                          .add(LoadChildReward(rewardId: id));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        padding: REdgeInsets.all(3),
                        height: 48.h,
                        width: 70.w,
                        color: Color.fromRGBO(217, 217, 217, 1),
                        child: CachedNetworkImage(
                          imageUrl: photo.toString(),
                          placeholder: ((context, url) =>
                              CircularProgressIndicator()),
                          errorWidget: (context, url, error) => SizedBox(),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: state.listOfRewards?.purchasedRewards?.length ?? 3,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 40.w);
                },
              ));
        });
  }
}
