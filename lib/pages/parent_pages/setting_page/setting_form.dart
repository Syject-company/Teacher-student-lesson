import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:tutor/constants/icons.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/flutter_flow/flutter_flow_widgets.dart';
import 'package:tutor/navigation/parent_nav_page.dart';
import 'package:tutor/pages/parent_pages/login_registe_parent/login_registe_parent_widget.dart';
import 'package:tutor/pages/parent_pages/setting_page/bloc/setting_bloc.dart';
import 'package:tutor/pages/registration/bloc/reg_bloc.dart';
import 'package:tutor/pages/registration/bloc/reg_event.dart';
import 'package:tutor/pages/registration/bloc/reg_state.dart';
import 'package:tutor/pages/registration/fields/oldPassword.dart';
import 'package:tutor/pages/child_pages/registration_child/child_registr_form.dart';
import 'package:tutor/pages/child_pages/registration_child/child_registration_widget.dart';
import 'package:tutor/utils/validators/email_validator.dart';
import 'package:tutor/pages/welcome/welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:tutor/utils/model/child_by_id_model/edit_child.dart';
import 'package:tutor/utils/repository/repositories.dart';
import 'package:tutor/widgets/add_button.dart';
import 'package:tutor/widgets/fields_inputs/auth_date_field.dart';
import 'package:tutor/widgets/fields_inputs/auth_text_field.dart';
import 'package:tutor/widgets/titles/back_title.dart';
import 'package:tutor/widgets/titles/choose_avatar_title.dart';
import 'package:tutor/widgets/titles/top_title.dart';

import 'package:tutor/widgets/titles/title_text.dart';

class SettingPageForm extends StatefulWidget {
  final int? wentToindex;
  final bool isChild;
  const SettingPageForm({Key? key, this.wentToindex, required this.isChild})
      : super(key: key);

  @override
  State<SettingPageForm> createState() => _SettingPageFormState();
}

class _SettingPageFormState extends State<SettingPageForm>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    widget.wentToindex != null
        ? _tabController.index = widget.wentToindex!
        : null;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegState>(
      listener: (context, state) {
        if (state is FailureState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Enter correct data'),
            backgroundColor: Colors.blue,
          ));
        }
      },
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          MainSettings(tabController: _tabController, isChild: widget.isChild),
          ChangePassword(tabController: _tabController),
          ManageChildren(tabController: _tabController),
          SingleChild(tabController: _tabController),
          EditChildren(tabController: _tabController),
        ],
      ),
    );
  }
}

class SingleChild extends StatelessWidget {
  const SingleChild({
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
          BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              return Stack(children: [
                TitleText(text: '${state.childById?.name}'),
                SettingOptions(controller: _tabController, state: state)
              ]);
            },
          ),
          SingleChildBody(controller: _tabController),
        ],
      ),
    );
  }
}

class SettingOptions extends StatelessWidget {
  final SettingState state;
  final TabController controller;
  const SettingOptions(
      {Key? key, required this.controller, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 357.w,
        top: 8.h,
        child: AddButton(
          onPressed: () {
            context.read<SettingBloc>().add(LoadSettingPhoto());
            openDialog(context, state, controller);
          },
          controller: controller,
          icon: Dot.dot_3,
        ));
  }

  void openDialog(BuildContext context, SettingState state, controller) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
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
                      controller.index = 4;
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
                      context.read<SettingBloc>().add(
                          DeleteChildEvent(childId: state.childById?.id ?? ''));
                      controller.index = 2;
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class ManageChildren extends StatelessWidget {
  const ManageChildren({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      buildWhen: (previous, current) =>
          previous.listOfChildren?.length != current.listOfChildren?.length,
      builder: (context, state) {
        context.read<SettingBloc>().add(LoadSettingChildren());
        return SingleChildScrollView(
          child: Column(
            children: [
              TopTitle(
                  controller: _tabController,
                  backArrowTap: () => _tabController.index = 0),
              Stack(children: [
                TitleText(text: 'Manage Child'),
                Positioned(
                    left: 357.w,
                    top: 8.h,
                    child: AddButton(
                        controller: _tabController,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChildRegistrationWidget(
                                    isAddChild: true)))))
              ]),
              ManageChildBody(controller: _tabController),
            ],
          ),
        );
      },
    );
  }
}

class ChangePassword extends StatelessWidget {
  const ChangePassword({
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
            backArrowTap: () => _tabController.index = 0,
          ),
          TitleText(text: 'Change Password'),
          OldPasswordField(),
          PasswordField(),
          ConfirmPasswordField(),
          SizedBox(height: 200.h),
          ChangePasswordButton(),
        ],
      ),
    );
  }
}

class EditChildren extends StatelessWidget {
  const EditChildren({Key? key, required TabController tabController})
      : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitle(
            controller: _tabController,
            backArrowTap: () => _tabController.index = 0,
          ),
          TitleText(text: 'Edit Child'),
          EditNameField(),
          EditBirthField(),
          ChooseAvatarTitle(),
          EditAvatar(),
          EditChildButton(),
        ],
      ),
    );
  }
}

class EditChildButton extends StatelessWidget {
  const EditChildButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.childById?.id != current.childById?.id,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
          child: FFButtonWidget(
            onPressed: () {
              if (!state.status!.isInvalid) {
                context.read<SettingBloc>().add(EditChildEvent(
                      childData: EditedChild(
                        id: state.childById?.id ?? '',
                        childImageId: state.childImageId != ''
                            ? state.childImageId ??
                                state.childById!.childImage.id
                            : state.childById!.childImage.id,
                        birthDate: state.dateOfBirth?.value != ''
                            ? DateTime.tryParse(state.dateOfBirth!.value) ??
                                state.childById!.birthDate
                            : state.childById!.birthDate,
                        name: state.name?.value != ''
                            ? state.name?.value ?? state.childById!.name
                            : state.childById!.name,
                      ),
                    ));

                // _msg(context, state.errorMessage);

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NavBarPage(initialPage: 'SettingPage')));
              } else {
                _msg(context, 'Enter correct data');
              }
            },
            text: 'Edit',
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
          ),
        );
      },
    );
  }
}

class MainSettings extends StatelessWidget {
  final bool isChild;

  const MainSettings({
    Key? key,
    required TabController tabController,
    required this.isChild,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitle(controller: _tabController),
          TitleText(text: 'Settings'),
          SettingsBody(
            tabController: _tabController,
            isChild: isChild,
          ),
          SizedBox(height: 275.h),
        ],
      ),
    );
  }
}

class SingleChildBody extends StatelessWidget {
  final TabController controller;
  const SingleChildBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      buildWhen: (previous, current) =>
          previous.childById?.id != current.childById?.id,
      builder: (context, state) {
        final image = state.childById?.childImage.url ?? '';
        final title = state.childById?.name ?? '';
        final DateTime creation = state.childById?.birthDate ?? DateTime.now();
        final childId = state.childById?.id ?? '';
        final childPoints = state.childById?.childUserStatistic?.points ?? '';
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
                  '$childPoints points',
                  style: FlutterFlowTheme.of(context).title3.override(
                        fontFamily: FlutterFlowTheme.of(context).title3Family,
                        fontSize: 25.sp,
                      ),
                ),
              ),
              Padding(
                padding: REdgeInsetsDirectional.fromSTEB(80, 20, 80, 15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Age',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                    Text(
                      '${DateTime.now().year - creation.year}',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: REdgeInsetsDirectional.fromSTEB(80, 0, 80, 14),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date of Biirth',
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
            ],
          ),
        );
      },
    );
  }
}

class ManageChildBody extends StatelessWidget {
  const ManageChildBody({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      buildWhen: (previous, current) =>
          previous.listOfChildren?.length != current.listOfChildren?.length,
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
              var childPoints = state.listOfChildren
                      ?.map((e) => e.childUserStatistic?.points)
                      .toList()[index] ??
                  '';
              var sectionId = state.childById?.id ?? '';
              return Padding(
                padding: REdgeInsetsDirectional.fromSTEB(21, 0, 21, 0),
                child: InkWell(
                  onTap: () {
                    context
                        .read<SettingBloc>()
                        .add(LoadChildById(childId: childId));

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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).title3,
                              ),
                              Text(
                                '$childPoints points',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyText2Family,
                                        color: Color.fromRGBO(69, 168, 109, 1)),
                              ),
                            ],
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

class OldPasswordField extends StatelessWidget {
  const OldPasswordField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegState>(
      buildWhen: (previous, current) =>
          previous.oldPassword != current.oldPassword,
      builder: (context, state) {
        return Container(
            margin: REdgeInsetsDirectional.fromSTEB(30, 15, 25, 0),
            width: 378.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: AuthTextField(
                initialValue: state.oldPassword.value,
                label: 'Old Password',
                error: state.oldPassword.error.title,
                isPasswordField: true,
                onChanged: (oldPassword) => context
                    .read<RegistrationBloc>()
                    .add(OldPasswordChanged(oldPassword: oldPassword)),
                keyboardType: TextInputType.visiblePassword));
      },
    );
  }
}

class SettingsBody extends StatelessWidget {
  final TabController tabController;
  final bool isChild;
  const SettingsBody({
    Key? key,
    required this.tabController,
    required this.isChild,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegState>(
      buildWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage,
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Align(
            alignment: AlignmentDirectional(-0.75, 0),
            child: Padding(
              padding: REdgeInsetsDirectional.fromSTEB(0, 35, 0, 37),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !isChild
                      ? BackTitle(
                          text: 'Manage Children',
                          onTap: () {
                            tabController.index = 2;
                          },
                        )
                      : SizedBox.shrink(),
                  !isChild
                      ? BackTitle(
                          tabController: tabController,
                          text: 'Change Password',
                          onTap: () => tabController.index = 1)
                      : SizedBox.shrink(),
                  BackTitle(
                    text: 'Log out',
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginRegisteParentWidget(
                              userRepository: UserRepository(),
                            ),
                          ));
                      UserRepository().deleteToken();
                    },
                  ),
                  !isChild
                      ? BackTitle(
                          text: 'Delete account',
                          onTap: () {
                            context
                                .read<RegistrationBloc>()
                                .add(DeleteParentEvent());
                            _msg(context, state.errorMessage);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WelcomeWidget(),
                                ));
                          },
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 428,
      height: 180,
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
            height: 152,
            decoration: BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(33, 0, 0, 0),
                    child: Text(
                      'Hello, John!',
                      style: FlutterFlowTheme.of(context).title1,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(2, 30, 13, 0),
                  child: Image.asset(
                    'assets/images/No_Subscrib.png',
                    width: 133,
                    height: 123,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).primaryBtnText,
                    width: 0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _msg(_, txt) {
  var er = txt.toString();
  if (er == 'null') er = ('Compleated');

  ScaffoldMessenger.of(_).showSnackBar(SnackBar(
    content: Text(er),
    backgroundColor: Colors.redAccent,
  ));
}

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegState>(
      buildWhen: ((previous, current) {
        return previous.status != current.status;
      }),
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
          child: FFButtonWidget(
            onPressed: () {
              if (state.status.isValidated) {
                context.read<RegistrationBloc>().add(RenewParentPassword());

                _msg(context, state.errorMessage);

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeWidget()));
              } else {
                _msg(context, 'Enter correct data');
              }
            },
            text: 'Change',
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
          ),
        );
      },
    );
  }
}

class EditBirthField extends StatelessWidget {
  const EditBirthField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      buildWhen: (previous, current) =>
          previous.dateOfBirth != current.dateOfBirth,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(25, 0, 25, 30),
          child: Container(
            width: 378.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: AuthDateField(
              initialDate: state.childById?.birthDate,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              onDateSaved: (dob) {
                context
                    .read<SettingBloc>()
                    .add(EditDOBChanged(dateOfBirth: dob.toString()));
              },
            ),
          ),
        );
      },
    );
  }
}

class EditNameField extends StatelessWidget {
  const EditNameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(25, 30, 25, 30),
          child: Container(
              width: 378.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: AuthTextField(
                  initialValue: state.childById?.name,
                  label: 'Name',
                  validator: Validator().validateName,
                  onChanged: (name) => context
                      .read<SettingBloc>()
                      .add(EditNameChanged(name: name)),
                  keyboardType: TextInputType.name)),
        );
      },
    );
  }
}

class EditAvatar extends StatefulWidget {
  EditAvatar({Key? key}) : super(key: key);

  @override
  State<EditAvatar> createState() => _EditAvatarState();
}

class _EditAvatarState extends State<EditAvatar> {
  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
        buildWhen: (previous, current) =>
            previous.photo?.length != current.photo?.length,
        builder: (context, state) {
          return Container(
              margin: REdgeInsets.only(bottom: 110),
              height: 80.h,
              width: 320.w,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var id = state.photo?.map((e) => e.id).toList()[index] ?? '';
                  return InkWell(
                    onTap: () {
                      setState(() => _selectedIndex = index);
                      context
                          .read<SettingBloc>()
                          .add(EditAvatarSelected(childImageId: id));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 48.h,
                        width: 70.w,
                        color: index == _selectedIndex
                            ? Colors.blue
                            : Color.fromRGBO(217, 217, 217, 1),
                        child: CachedNetworkImage(
                          imageUrl:
                              state.photo?.map((e) => e.url).toList()[index] ??
                                  '',
                          placeholder: ((context, url) =>
                              CircularProgressIndicator()),
                          errorWidget: (context, url, error) => SizedBox(),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: state.photo?.length ?? 3,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 40.w);
                },
              ));
        });
  }
}
