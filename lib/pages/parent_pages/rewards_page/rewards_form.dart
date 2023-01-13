import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:tutor/constants/icons.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/flutter_flow/flutter_flow_widgets.dart';
import 'package:tutor/navigation/parent_nav_page.dart';
import 'package:tutor/pages/parent_pages/rewards_page/bloc/rewards_bloc.dart';
import 'package:tutor/utils/validators/email_validator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tutor/utils/model/chore/chore_class.dart';
import 'package:tutor/utils/model/image_model/image_model.dart';
import 'package:tutor/utils/model/create_model/create_reward_model.dart';
import 'package:tutor/utils/model/update_model/update_reward.dart';
import 'package:tutor/widgets/add_button.dart';
import 'package:tutor/widgets/fields_inputs/auth_text_field.dart';
import 'package:tutor/widgets/fields_inputs/reward_points_field.dart';
import 'package:tutor/widgets/titles/top_title.dart';
import 'package:tutor/widgets/rewards_widgets/rewards_title.dart';

class RewardsForm extends StatefulWidget {
  const RewardsForm({Key? key}) : super(key: key);

  @override
  State<RewardsForm> createState() => _RewardsFormState();
}

class _RewardsFormState extends State<RewardsForm>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 6);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('1');
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: [
        Rewards(tabController: _tabController),
        Reward(tabController: _tabController),
        RewardCreation(tabController: _tabController),
        EditReward(tabController: _tabController),
        ChildSelecton(tabController: _tabController),
        PicSelecton(tabController: _tabController)
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
    print('2');
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitle(controller: _tabController),
          Stack(children: [
            RewardsTitle(controller: _tabController),
            Positioned(
                left: 357.w,
                top: 8.h,
                child: AddButton(
                    controller: _tabController,
                    onPressed: () => _tabController.index = 2))
          ]),
          RewardsBody(controller: _tabController),
        ],
      ),
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
    print('3');
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitle(
              controller: _tabController,
              backArrowTap: () => _tabController.index = 0),
          Stack(children: [
            RewardsTitle(controller: _tabController),
            SelectOptions(controller: _tabController),
          ]),
          RewardBody(controller: _tabController),
        ],
      ),
    );
  }
}

class SelectOptions extends StatelessWidget {
  final TabController controller;
  const SelectOptions({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 357.w,
      top: 8.h,
      child: BlocBuilder<RewardsBloc, RewardsState>(
        builder: (context, state) {
          return AddButton(
            onPressed: () {
              context.read<RewardsBloc>().add(EditRewardEvent(
                  description: state.rewardData?.description ?? '',
                  rewardPrice: state.rewardData?.price ?? 0,
                  rewardTitle: state.rewardData?.title ?? '',
                  selectedChildren:
                      state.rewardData?.assignedChildUsersRewards ?? [],
                  selectedRewardImage:
                      state.rewardData?.rewardImage ?? ImageModel(id: '')));
              openDialog(context, state, controller);
            },
            controller: controller,
            icon: Dot.dot_3,
          );
        },
      ),
    );
  }

  void openDialog(BuildContext context, state, controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        alignment: Alignment.topRight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        insetPadding: REdgeInsets.fromLTRB(0, 180, 80, 0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 80.h,
              width: 324.w,
              child: TextButton(
                child: Text(
                  'Change',
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                onPressed: () {
                  controller.index = 3;
                  Navigator.of(context).pop();
                },
              ),
            ),
            Divider(color: Colors.grey, height: 2),
            SizedBox(
              width: 324.w,
              height: 80.h,
              child: TextButton(
                child: Text('Delete',
                    style: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Montserrat',
                          color: Colors.red,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        )),
                onPressed: () {
                  context
                      .read<RewardsBloc>()
                      .add(DeleteReward(rewardId: state.rewardData?.id ?? ''));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NavBarPage(initialPage: 'RewardsPage'),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RewardCreation extends StatelessWidget {
  const RewardCreation({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    print('4');
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitle(
              controller: _tabController,
              backArrowTap: () => _tabController.index = 0),
          RewardsTitle(controller: _tabController),
          CreationBody(controller: _tabController),
        ],
      ),
    );
  }
}

class EditReward extends StatelessWidget {
  const EditReward({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    print('5');
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitle(
              controller: _tabController,
              backArrowTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NavBarPage(initialPage: 'RewardsPage'),
                  ))),
          RewardsTitle(controller: _tabController),
          CreationBody(controller: _tabController),
        ],
      ),
    );
  }
}

class ChildSelecton extends StatelessWidget {
  const ChildSelecton({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    print('6');
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitle(controller: _tabController),
          RewardsTitle(controller: _tabController),
          SelectRewardChild(controller: _tabController),
        ],
      ),
    );
  }
}

class PicSelecton extends StatelessWidget {
  const PicSelecton({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    print('7');
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitle(controller: _tabController),
          RewardsTitle(controller: _tabController),
          SelectRewardPicture(controller: _tabController),
        ],
      ),
    );
  }
}

class SelectRewardPicture extends StatelessWidget {
  const SelectRewardPicture({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardsBloc, RewardsState>(
      buildWhen: (previous, current) =>
          previous.listOfPhoto?.length != current.listOfPhoto?.length,
      builder: (context, state) {
        return Container(
          margin: REdgeInsetsDirectional.fromSTEB(34, 37, 34, 0),
          height: 524.h,
          child: GridView.builder(
            primary: true,
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 30,
              mainAxisSpacing: 0,
              childAspectRatio: 1,
            ),
            itemCount: state.listOfPhoto?.length ?? 0,
            itemBuilder: (context, index) {
              final String photoId =
                  state.listOfPhoto?.map((e) => e.id).toList()[index] ?? '';
              final String imageUrl =
                  state.listOfPhoto?.map((e) => e.url).toList()[index] ?? '';
              return InkWell(
                  onTap: () {
                    context.read<RewardsBloc>().add(AddImage(
                        selectedRewardImage:
                            ImageModel(url: imageUrl, id: photoId)));

                    state.updateCalled == true
                        ? controller.index = 3
                        : controller.index = 2;
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

class SelectRewardChild extends StatefulWidget {
  const SelectRewardChild({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TabController controller;

  @override
  State<SelectRewardChild> createState() => _SelectRewardChildState();
}

class _SelectRewardChildState extends State<SelectRewardChild> {
  List _selectedIndex = [];
  List<EdChildUsersChore> _children = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardsBloc, RewardsState>(
      buildWhen: (previous, current) =>
          previous.listOfChildren?.length != current.listOfChildren?.length,
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 480.h,
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
                  var name = state.listOfChildren
                          ?.map((e) => e.name)
                          .toList()[index] ??
                      '';

                  return Padding(
                    padding: REdgeInsetsDirectional.fromSTEB(21, 0, 21, 0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (_selectedIndex.contains(index)) {
                            _selectedIndex.remove(index);
                          } else {
                            _selectedIndex.add(index);
                          }
                        });
                        _children = (_selectedIndex
                            .map((e) => state.listOfChildren![e])
                            .toList());
                      },
                      child: Card(
                        elevation: 5,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: !_selectedIndex.contains(index)
                            ? Color(0xFFF5F6FA)
                            : Color(0xFF2BC0EF),
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
                                imageUrl: image,
                                placeholder: ((context, url) =>
                                    Center(child: CircularProgressIndicator())),
                                errorWidget: (context, url, error) =>
                                    SizedBox(),
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
                    ),
                  );
                },
              ),
            ),
            FFButtonWidget(
              onPressed: () {
                if (_children.isNotEmpty) {
                  (state.updateCalled == true)
                      ? widget.controller.index = 3
                      : widget.controller.index = 2;
                  context
                      .read<RewardsBloc>()
                      .add(AddChildren(selectedChildren: _children));
                }
              },
              text: 'Select',
              options: FFButtonOptions(
                width: 360.w,
                height: 60.h,
                color:
                    _children.isEmpty ? Color(0xFF9BA1A4) : Color(0xFF2BC0EF),
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
            )
          ],
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
    return BlocBuilder<RewardsBloc, RewardsState>(
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
                      creation.toString().length != 0
                          ? '$creation'.replaceRange(10, null, '')
                          : '',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: REdgeInsetsDirectional.fromSTEB(36, 20, 36, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Available for:',
                      style: FlutterFlowTheme.of(context).title3.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).title3Family,
                            fontSize: 25.sp,
                          ),
                    ),
                  ],
                ),
              ),
              AssignedChild()
            ],
          ),
        );
      },
    );
  }
}

class CreationBody extends StatelessWidget {
  final TabController controller;
  const CreationBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardsBloc, RewardsState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            NameField(),
            DescriptionField(),
            RewardPointInputField(),
            ChoosePicture(controller: controller),
            AssignedPicture(),
            ChooseChildren(controller: controller),
            AssignedSelectedChild(),
            pressCreateReward(state, context)
          ],
        );
      },
    );
  }

  FFButtonWidget pressCreateReward(RewardsState state, BuildContext context) {
    return FFButtonWidget(
      onPressed: () {
        if (validated(state)) {
          if (controller.index == 2) {
            context.read<RewardsBloc>().add(CreateReward(
                  createRewardModel: CreateRewardModel(
                    title: state.rewardTitle.value,
                    description: state.description.value,
                    price: state.rewardPrice ?? 0,
                    created: DateTime.now(),
                    childrenIds:
                        state.selectedChildren?.map((e) => e.id).toList() ?? [],
                    rewardImageId: state.selectedRewardImage?.id ?? '',
                  ),
                ));
          } else if (controller.index == 3) {
            context.read<RewardsBloc>().add(UpdateReward(
                    updateRewardModel: UpdateRewardModel(
                  id: state.rewardData?.id ?? '',
                  title: state.rewardTitle.value,
                  description: state.description.value,
                  price: state.rewardPrice ?? 0,
                  created: DateTime.now(),
                  childrenIds:
                      state.selectedChildren?.map((e) => e.id).toList() ?? [],
                  rewardImageId: state.selectedRewardImage?.id ?? '',
                )));
          }

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NavBarPage(
                  initialPage: 'RewardsPage',
                ),
              ));
        }
      },
      text: (controller.index == 2) ? 'Create' : 'Update',
      options: FFButtonOptions(
        width: 360.w,
        height: 60.h,
        color: validated(state) ? Color(0xFF2BC0EF) : Color(0xFF9BA1A4),
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
  }

  bool validated(RewardsState state) {
    return state.status.isValid &&
        state.selectedChildren?.length != 0 &&
        state.selectedRewardImage?.id.toString().length != 0 &&
        state.rewardPrice != 0 &&
        state.rewardPrice != null &&
        state.selectedChildren?.length != null &&
        state.selectedRewardImage?.id.toString().length != null;
  }
}

class ChooseChildren extends StatelessWidget {
  const ChooseChildren({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.fromSTEB(36, 20, 36, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Available for:        ',
            style: FlutterFlowTheme.of(context).title3.override(
                  fontFamily: FlutterFlowTheme.of(context).title3Family,
                  fontSize: 25.sp,
                ),
          ),
          AddButton(
              controller: controller,
              onPressed: () {
                context.read<RewardsBloc>().add(LoadChildren());
                controller.index = 4;
              })
        ],
      ),
    );
  }
}

class ChoosePicture extends StatelessWidget {
  const ChoosePicture({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.fromSTEB(36, 36, 36, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Choose a picture ',
            style: FlutterFlowTheme.of(context).title3.override(
                  fontFamily: FlutterFlowTheme.of(context).title3Family,
                  fontSize: 25.sp,
                ),
          ),
          AddButton(
              controller: controller,
              onPressed: () {
                context.read<RewardsBloc>().add(LoadRewardPhoto());
                controller.index = 5;
              })
        ],
      ),
    );
  }
}

class NameField extends StatelessWidget {
  const NameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardsBloc, RewardsState>(
      buildWhen: (previous, current) =>
          previous.rewardTitle != current.rewardTitle,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(25, 30, 25, 15),
          child: Container(
              width: 378.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: AuthTextField(
                  initialValue: state.rewardTitle.value,
                  label: 'Name',
                  validator: Validator().validateName,
                  onChanged: (name) => context
                      .read<RewardsBloc>()
                      .add(RewardNameChanged(rewardTitle: name)),
                  keyboardType: TextInputType.name)),
        );
      },
    );
  }
}

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardsBloc, RewardsState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(25, 0, 25, 15),
          child: Container(
              width: 378.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: AuthTextField(
                  initialValue: state.description.value,
                  label: 'Description',
                  validator: Validator().validateDescription,
                  onChanged: (description) => context
                      .read<RewardsBloc>()
                      .add(DescriptionChanged(description: description)),
                  keyboardType: TextInputType.name)),
        );
      },
    );
  }
}

class RewardsBody extends StatelessWidget {
  final TabController controller;
  const RewardsBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardsBloc, RewardsState>(
      buildWhen: (previous, current) =>
          previous.listOfRewards?.length != current.listOfRewards?.length,
      builder: (context, state) {
        context.read<RewardsBloc>().add(LoadRewards());
        return Container(
          margin: EdgeInsets.only(top: 20),
          height: 545.h,
          child: Scrollbar(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              primary: false,
              itemCount: state.listOfRewards?.length ?? 0,
              itemBuilder: (context, index) {
                final rewardImageUrl = state.listOfRewards
                        ?.map((e) => e.rewardImage.url)
                        .toList()[index] ??
                    '';
                final rewardName =
                    state.listOfRewards?.map((e) => e.title).toList()[index] ??
                        '';
                final rewardId =
                    state.listOfRewards?.map((e) => e.id).toList()[index] ?? '';
                final rewardPrice =
                    state.listOfRewards?.map((e) => e.price).toList()[index] ??
                        0;
                final color1 = const Color.fromRGBO(244, 219, 129, 1);

                return Padding(
                  padding: REdgeInsetsDirectional.fromSTEB(21, 0, 21, 0),
                  child: InkWell(
                    onTap: () {
                      print(rewardId);
                      context.read<RewardsBloc>().add(LoadReward(
                            rewardId: rewardId,
                          ));
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
                            padding:
                                REdgeInsetsDirectional.fromSTEB(23, 14, 23, 14),
                            child: CachedNetworkImage(
                              height: 77.h,
                              imageUrl: rewardImageUrl,
                              placeholder: ((context, url) =>
                                  Center(child: CircularProgressIndicator())),
                              errorWidget: (context, url, error) => SizedBox(),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              rewardName,
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context).title3,
                            ),
                          ),
                          Padding(
                            padding:
                                REdgeInsetsDirectional.fromSTEB(0, 8, 23, 8),
                            child: Container(
                                child: Center(
                                  child: Text('$rewardPrice',
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
        );
      },
    );
  }
}

class AssignedChild extends StatelessWidget {
  const AssignedChild({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardsBloc, RewardsState>(
      buildWhen: (previous, current) =>
          previous.rewardData?.assignedChildUsersRewards?.length !=
          current.rewardData?.assignedChildUsersRewards?.length,
      builder: (context, state) {
        var count = state.rewardData?.assignedChildUsersRewards?.length ?? 0;
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
              var image = state.rewardData?.assignedChildUsersRewards!
                  .map((e) => e.childImage.url)
                  .toList()[index];
              var name = state.rewardData?.assignedChildUsersRewards
                  ?.map((e) => e.name)
                  .toList()[index];
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
                          imageUrl: image ?? '',
                          placeholder: ((context, url) =>
                              Center(child: CircularProgressIndicator())),
                          errorWidget: (context, url, error) => SizedBox(),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          name ?? '',
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

class AssignedSelectedChild extends StatelessWidget {
  const AssignedSelectedChild({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardsBloc, RewardsState>(
      buildWhen: (previous, current) =>
          previous.selectedChildren?.length != current.selectedChildren?.length,
      builder: (context, state) {
        var count = state.selectedChildren?.length ?? 0;
        return Container(
          height: (count > 0) ? 128.h * count : 80.h,
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
              var image = state.selectedChildren!
                  .map((e) => e.childImage.url)
                  .toList()[index];
              var name =
                  state.selectedChildren!.map((e) => e.name).toList()[index];
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

class AssignedPicture extends StatelessWidget {
  const AssignedPicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardsBloc, RewardsState>(
      buildWhen: (previous, current) =>
          previous.selectedRewardImage?.url != current.selectedRewardImage?.url,
      builder: (context, state) {
        var count = state.selectedRewardImage?.url?.isNotEmpty ?? false;
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
              margin: REdgeInsetsDirectional.fromSTEB(45, 14, 0, 14),
              height: count ? 60.h : 0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBtnText,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: CachedNetworkImage(
                height: 60.h,
                imageUrl: state.selectedRewardImage?.url ?? '',
                placeholder: ((context, url) =>
                    Center(child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => SizedBox(),
                fit: BoxFit.contain,
              )),
        );
      },
    );
  }
}
