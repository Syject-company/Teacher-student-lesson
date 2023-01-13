import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:tutor/constants/icons.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/flutter_flow/flutter_flow_widgets.dart';
import 'package:tutor/navigation/parent_nav_page.dart';
import 'package:tutor/pages/parent_pages/chores_page/bloc/chores_bloc.dart';
import 'package:tutor/utils/validators/email_validator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tutor/utils/model/chore/chore_class.dart';
import 'package:tutor/utils/model/create_model/create_chore_model.dart';
import 'package:tutor/utils/model/image_model/image_model.dart';
import 'package:tutor/utils/model/update_model/update_chore.dart';
import 'package:tutor/widgets/add_button.dart';
import 'package:tutor/widgets/chores_widgets/chores_title.dart';
import 'package:tutor/widgets/chores_widgets/time_input_field.dart';
import 'package:tutor/widgets/fields_inputs/auth_text_field.dart';
import 'package:tutor/widgets/titles/top_title.dart';

class ChoresForm extends StatefulWidget {
  const ChoresForm({Key? key}) : super(key: key);

  @override
  State<ChoresForm> createState() => _ChoresFormState();
}

class _ChoresFormState extends State<ChoresForm>
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
        Chores(tabController: _tabController),
        Chore(tabController: _tabController),
        ChoreCreation(tabController: _tabController),
        EditChore(tabController: _tabController),
        ChildSelecton(tabController: _tabController),
        PicSelecton(tabController: _tabController)
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
    print('2');
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitle(controller: _tabController),
          Stack(children: [
            ChoresTitle(controller: _tabController),
            Positioned(
                left: 357.w,
                top: 8.h,
                child: AddButton(
                    controller: _tabController,
                    onPressed: () => _tabController.index = 2))
          ]),
          ChoresBody(controller: _tabController),
        ],
      ),
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
    print('3');
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitle(
              controller: _tabController,
              backArrowTap: () => _tabController.index = 0),
          Stack(children: [
            ChoresTitle(controller: _tabController),
            SelectOptions(controller: _tabController),
          ]),
          ChoreBody(controller: _tabController),
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
      child: BlocBuilder<ChoresBloc, ChoresState>(
        builder: (context, ChoresState state) {
          return AddButton(
            onPressed: () {
              context.read<ChoresBloc>().add(EditChoreEvent(
                    description: state.choreData?.description ?? '',
                    chorePrice: state.choreData?.price ?? 0,
                    choreTitle: state.choreData?.title ?? '',
                    selectedChildren:
                        state.choreData?.assignedChildUsersChores! ?? [],
                    selectedChoreImage:
                        state.choreData?.choreImage ?? ImageModel(id: ''),
                    time:
                        '${state.choreData?.time?.hour}:${state.choreData?.time?.minute}',
                  ));
              openDialog(context, state, controller);
            },
            controller: controller,
            icon: Dot.dot_3,
          );
        },
      ),
    );
  }

  void openDialog(BuildContext context, ChoresState state, controller) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
                      .read<ChoresBloc>()
                      .add(DeleteChore(choreId: state.choreData?.id ?? ''));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NavBarPage(initialPage: 'ChoresPage'),
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

class ChoreCreation extends StatelessWidget {
  const ChoreCreation({
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
          ChoresTitle(controller: _tabController),
          CreationBody(controller: _tabController),
        ],
      ),
    );
  }
}

class EditChore extends StatelessWidget {
  const EditChore({
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
                    builder: (context) => NavBarPage(initialPage: 'ChoresPage'),
                  ))),
          ChoresTitle(controller: _tabController),
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
          ChoresTitle(controller: _tabController),
          SelectChoreChild(controller: _tabController),
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
          ChoresTitle(controller: _tabController),
          SelectChorePicture(controller: _tabController),
        ],
      ),
    );
  }
}

class SelectChorePicture extends StatelessWidget {
  const SelectChorePicture({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChoresBloc, ChoresState>(
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
                    context.read<ChoresBloc>().add(AddImage(
                        selectedChoreImage:
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

class SelectChoreChild extends StatefulWidget {
  const SelectChoreChild({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TabController controller;

  @override
  State<SelectChoreChild> createState() => _SelectChoreChildState();
}

class _SelectChoreChildState extends State<SelectChoreChild> {
  List _selectedIndex = [];
  List<EdChildUsersChore> _children = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChoresBloc, ChoresState>(
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
                      .read<ChoresBloc>()
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

class ChoreBody extends StatelessWidget {
  final TabController controller;
  const ChoreBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChoresBloc, ChoresState>(
      buildWhen: (previous, current) =>
          previous.choreData?.id != current.choreData?.id,
      builder: (context, state) {
        final image = state.choreData?.choreImage.url ?? '';
        final title = state.choreData?.title ?? '';
        final description = state.choreData?.description ?? '';
        final chorePrice = state.choreData?.price ?? '';
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
                padding: REdgeInsetsDirectional.fromSTEB(36, 30, 36, 0),
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
              AssignedChild(),
              Padding(
                padding: REdgeInsetsDirectional.fromSTEB(36, 5, 36, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Completed:',
                      style: FlutterFlowTheme.of(context).title3.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).title3Family,
                            fontSize: 25.sp,
                          ),
                    ),
                  ],
                ),
              ),
              CompletedChild(controller: controller)
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
    return BlocBuilder<ChoresBloc, ChoresState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            NameField(),
            DescriptionField(),
            PointInputField(),
            TimeField(),
            ChoosePicture(controller: controller),
            AssignedPicture(),
            ChooseChildren(controller: controller),
            AssignedSelectedChild(),
            pressCreateChore(state, context)
          ],
        );
      },
    );
  }

  FFButtonWidget pressCreateChore(ChoresState state, BuildContext context) {
    return FFButtonWidget(
      onPressed: () {
        if (validated(state)) {
          if (controller.index == 2) {
            context.read<ChoresBloc>().add(CreateChore(
                  createChoreModel: CreateChoreModel(
                    title: state.choreTitle.value,
                    description: state.description.value,
                    price: state.chorePrice ?? 0,
                    time: DateTime.parse(
                        '1111-11-11T${state.time.value}:00.000Z'),
                    childrenIds:
                        state.selectedChildren?.map((e) => e.id).toList() ?? [],
                    choreImageId: state.selectedChoreImage?.id ?? '',
                  ),
                ));
          } else if (controller.index == 3) {
            print(DateTime.parse('1111-11-11T${state.time.value}:00.000Z'));
            context.read<ChoresBloc>().add(UpdateChore(
                    updateChoreModel: UpdateChoreModel(
                  id: state.choreData?.id ?? '',
                  title: state.choreTitle.value,
                  description: state.description.value,
                  price: state.chorePrice ?? 0,
                  time:
                      DateTime.parse('1111-11-11T${state.time.value}:00.000Z'),
                  childrenIds:
                      state.selectedChildren?.map((e) => e.id).toList() ?? [],
                  choreImageId: state.selectedChoreImage?.id ?? '',
                )));
          }

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NavBarPage(
                  initialPage: 'ChoresPage',
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

  bool validated(ChoresState state) {
    return state.status.isValid &&
        state.selectedChildren?.length != 0 &&
        state.selectedChoreImage?.id.toString().length != 0 &&
        state.chorePrice != 0 &&
        state.chorePrice != null &&
        state.selectedChildren?.length != null &&
        state.selectedChoreImage?.id.toString().length != null;
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
                context.read<ChoresBloc>().add(LoadChoresChildren());
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
                context.read<ChoresBloc>().add(LoadChoresPhoto());
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
    return BlocBuilder<ChoresBloc, ChoresState>(
      buildWhen: (previous, current) =>
          previous.choreTitle != current.choreTitle,
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
                  initialValue: state.choreTitle.value,
                  label: 'Name',
                  validator: Validator().validateName,
                  onChanged: (name) => context
                      .read<ChoresBloc>()
                      .add(ChoresNameChanged(choreTitle: name)),
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
    return BlocBuilder<ChoresBloc, ChoresState>(
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
                      .read<ChoresBloc>()
                      .add(DescriptionChoresChanged(description: description)),
                  keyboardType: TextInputType.name)),
        );
      },
    );
  }
}

class PointInputField extends StatefulWidget {
  const PointInputField({
    Key? key,
  }) : super(key: key);

  @override
  State<PointInputField> createState() => _PointInputFieldState();
}

class _PointInputFieldState extends State<PointInputField> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<int>> _genders = [
      DropdownMenuItem(
        child: Text('10'),
        value: 10,
      ),
      DropdownMenuItem(
        child: Text('20'),
        value: 20,
      ),
      DropdownMenuItem(
        child: Text('30'),
        value: 30,
      ),
      DropdownMenuItem(
        child: Text('40'),
        value: 40,
      ),
      DropdownMenuItem(
        child: Text('50'),
        value: 50,
      ),
      DropdownMenuItem(
        child: Text('60'),
        value: 60,
      ),
      DropdownMenuItem(
        child: Text('70'),
        value: 70,
      ),
      DropdownMenuItem(
        child: Text('80'),
        value: 80,
      ),
      DropdownMenuItem(
        child: Text('90'),
        value: 90,
      ),
      DropdownMenuItem(
        child: Text('100'),
        value: 100,
      ),
    ];
    return BlocBuilder<ChoresBloc, ChoresState>(
      buildWhen: (previous, current) =>
          previous.selectedChildren != current.selectedChildren,
      builder: (context, state) {
        var _selectedValue = state.chorePrice;

        return Container(
          margin: REdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
          width: 378.w,
          height: 70.h,
          child: DropdownButtonFormField<int>(
            decoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x00000000)),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              labelText: 'Select points',
              labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF95A1AC),
                  fontSize: 14),
              hintStyle: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF95A1AC),
                  fontSize: 14),
              errorStyle: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Montserrat', color: Colors.red, fontSize: 14.sp),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x00000000)),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x00000000)),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x00000000)),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              filled: true,
              fillColor: Color(0xFFF5F6FA),
              contentPadding: REdgeInsetsDirectional.fromSTEB(20, 24, 20, 0),
            ),
            isDense: true,
            value: _selectedValue,
            key: const Key('Points'),
            onChanged: (price) {
              setState(() {
                context.read<ChoresBloc>().add(PriceChoreChanged(
                      chorePrice: price ?? 1,
                    ));
              });
            },
            items: _genders,
          ),
        );
      },
    );
  }
}

class TimeField extends StatelessWidget {
  const TimeField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChoresBloc, ChoresState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(25, 15, 25, 0),
          child: Container(
              width: 378.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: TimeInputField()),
        );
      },
    );
  }
}

class ChoresBody extends StatelessWidget {
  final TabController controller;
  const ChoresBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChoresBloc, ChoresState>(
      buildWhen: (previous, current) =>
          previous.listOfChores?.length != current.listOfChores?.length,
      builder: (context, state) {
        context.read<ChoresBloc>().add(LoadChores());
        return Container(
          margin: EdgeInsets.only(top: 20),
          height: 545.h,
          child: Scrollbar(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              primary: true,
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
                    state.listOfChores?.map((e) => e.id).toList()[index] ?? '';
                final chorePrice =
                    state.listOfChores?.map((e) => e.price).toList()[index] ??
                        0;
                final color1 = const Color.fromRGBO(122, 186, 140, 1);

                return Padding(
                  padding: REdgeInsetsDirectional.fromSTEB(21, 0, 21, 0),
                  child: InkWell(
                    onTap: () {
                      context
                          .read<ChoresBloc>()
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
                            padding:
                                REdgeInsetsDirectional.fromSTEB(23, 14, 23, 14),
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
                            child: Text(
                              choreName,
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context).title3,
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
    return BlocBuilder<ChoresBloc, ChoresState>(
      buildWhen: (previous, current) =>
          previous.choreData?.assignedChildUsersChores?.length !=
          current.choreData?.assignedChildUsersChores?.length,
      builder: (context, state) {
        var count = state.choreData?.assignedChildUsersChores?.length ?? 0;
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
              var image = state.choreData?.assignedChildUsersChores!
                  .map((e) => e.childImage.url)
                  .toList()[index];
              var name = state.choreData?.assignedChildUsersChores
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

class CompletedChild extends StatelessWidget {
  final TabController controller;
  const CompletedChild({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChoresBloc, ChoresState>(
      buildWhen: (previous, current) =>
          previous.choreData?.completedChildUsersChores?.length !=
          current.choreData?.completedChildUsersChores?.length,
      builder: (context, state) {
        var count = state.choreData?.completedChildUsersChores?.length ?? 0;
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
              final choreId = state.choreData?.id ?? '';
              final image = state.choreData?.completedChildUsersChores!
                  .map((e) => e.childImage.url)
                  .toList()[index];
              final name = state.choreData?.completedChildUsersChores
                  ?.map((e) => e.name)
                  .toList()[index];
              final id = state.choreData?.completedChildUsersChores
                      ?.map((e) => e.id)
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
                      Padding(
                        padding: REdgeInsets.only(right: 20),
                        child: IconButton(
                            onPressed: () {
                              context.read<ChoresBloc>().add(
                                  ApproveChore(choreId: choreId, childId: id));
                              context.read<ChoresBloc>().add(LoadChore(
                                    choreId: choreId,
                                  ));
                            },
                            icon: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 42.h,
                            )),
                      )
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
    return BlocBuilder<ChoresBloc, ChoresState>(
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
    return BlocBuilder<ChoresBloc, ChoresState>(
      buildWhen: (previous, current) =>
          previous.selectedChoreImage?.url != current.selectedChoreImage?.url,
      builder: (context, state) {
        var count = state.selectedChoreImage?.url?.isNotEmpty ?? false;
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
                imageUrl: state.selectedChoreImage?.url ?? '',
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
