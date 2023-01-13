import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/flutter_flow/flutter_flow_widgets.dart';
import 'package:tutor/navigation/parent_nav_page.dart';
import 'package:tutor/pages/registration/bloc/reg_event.dart';
import 'package:tutor/pages/registration/bloc/reg_state.dart';
import 'package:tutor/pages/registration/fields/confirm_password.dart';
import 'package:tutor/pages/registration/fields/email.dart';
import 'package:tutor/pages/registration/fields/password.dart';
import 'package:tutor/utils/validators/email_validator.dart';
import 'package:tutor/pages/welcome/welcome_widget.dart';
import 'package:tutor/widgets/fields_inputs/auth_date_field.dart';
import 'package:tutor/widgets/fields_inputs/auth_text_field.dart';
import 'package:tutor/widgets/titles/choose_avatar_title.dart';
import '../../registration/bloc/reg_bloc.dart';

class ChildRegistrForm extends StatefulWidget {
  final bool? isAddChild;
  ChildRegistrForm({Key? key, this.isAddChild}) : super(key: key);

  @override
  State<ChildRegistrForm> createState() => _ChildRegistrFormState();
}

class _ChildRegistrFormState extends State<ChildRegistrForm>
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
    _tabController.addListener(() {});
    return BlocListener<RegistrationBloc, RegState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            _msg(context, state.errorMessage);
          } else if (state.status.isSubmissionSuccess) {
            if (widget.isAddChild == null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NavBarPage(initialPage: 'HomePage')));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NavBarPage(
                          initialPage: 'SettingPage', wentToindex: 2)));
            }
          }
        },
        child: BlocBuilder<RegistrationBloc, RegState>(
          buildWhen: (previous, current) =>
              previous.photo?.length != previous.photo?.length,
          builder: (context, state) {
            context.read<RegistrationBloc>().add(LoadPhoto());
            return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TopScreen(),
                        ChildRegistrationTitle(),
                        EmailField(),
                        NameField(),
                        PasswordField(),
                        ConfirmPasswordField(),
                        RegistrNextButton(tabController: _tabController),
                        _tabController.index == 1
                            ? _BackButton(tabController: _tabController)
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TopScreen(),
                        BirthField(),
                        ChooseAvatarTitle(),
                        AvatarGallery(),
                        RegistrFinalButton(),
                        _BackButton(tabController: _tabController),
                      ],
                    ),
                  )
                ]);
          },
        ));
  }

  void _msg(_, txt) {
    var er = txt.toString();
    if (er.contains(RegExp('[)]|[(]|[}]|[{]|\\]|[[]'))) {
      er = er.replaceAll(RegExp('[)]|[(]|[}]|[{]|\\]|[[]'), '');
    }
    er = er.replaceAll(RegExp('Å¡'), 'š');

    ScaffoldMessenger.of(_).showSnackBar(SnackBar(
      content: Text(er),
      backgroundColor: Colors.redAccent,
    ));
  }
}

class ChildRegistrationTitle extends StatelessWidget {
  const ChildRegistrationTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.fromSTEB(0, 35, 0, 30),
      child: Text(
        'Child Registration',
        textAlign: TextAlign.center,
        style: FlutterFlowTheme.of(context).title2,
      ),
    );
  }
}

class AvatarGallery extends StatefulWidget {
  AvatarGallery({Key? key}) : super(key: key);

  @override
  State<AvatarGallery> createState() => _AvatarGalleryState();
}

class _AvatarGalleryState extends State<AvatarGallery> {
  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegState>(
        buildWhen: (previous, current) =>
            previous.childImageId != current.childImageId,
        builder: (context, state) {
          return Padding(
            padding: REdgeInsetsDirectional.fromSTEB(0, 0, 0, 47),
            child: Container(
                height: 80.h,
                width: 320.w,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var id =
                        state.photo?.map((e) => e.id).toList()[index] ?? '';
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                        context
                            .read<RegistrationBloc>()
                            .add(AvatarSelected(childImageId: id));
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
                            imageUrl: state.photo
                                    ?.map((e) => e.url)
                                    .toList()[index] ??
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
                )),
          );
        });
  }
}

class TopScreen extends StatelessWidget {
  const TopScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 428.w,
      height: 282.h,
      decoration: BoxDecoration(
        color: Color(0xFF2BC0EF),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: REdgeInsetsDirectional.fromSTEB(0, 51, 0, 0),
        child: SvgPicture.asset(
          'assets/images/Group_426.svg',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
          child: Container(
              width: 378.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: AuthTextField(
                  initialValue: state.email.value,
                  label: 'Email',
                  error: state.email.error != null
                      ? (state.email.error as EmailValidationError).title
                      : null,
                  isPasswordField: false,
                  onChanged: (email) => context
                      .read<RegistrationBloc>()
                      .add(EmailChanged(email: email)),
                  keyboardType: TextInputType.emailAddress)),
        );
      },
    );
  }
}

class NameField extends StatelessWidget {
  const NameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(25, 15, 25, 0),
          child: Container(
              width: 378.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: AuthTextField(
                  initialValue: state.name.value,
                  label: 'Name',
                  validator: Validator().validateName,
                  isPasswordField: false,
                  onChanged: (name) => context
                      .read<RegistrationBloc>()
                      .add(NameChanged(name: name)),
                  keyboardType: TextInputType.name)),
        );
      },
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(25, 15, 25, 15),
          child: Container(
              width: 378.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: AuthTextField(
                  initialValue: state.password.value,
                  label: 'Password',
                  error: state.password.error.title,
                  isPasswordField: true,
                  onChanged: (password) => context
                      .read<RegistrationBloc>()
                      .add(PasswordChanged(password: password)),
                  keyboardType: TextInputType.visiblePassword)),
        );
      },
    );
  }
}

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(25, 0, 25, 28),
          child: Container(
              width: 378.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: AuthTextField(
                  initialValue: state.confirmPassword.value,
                  label: 'Confirm Password',
                  error: state.confirmPassword.error != null
                      ? (state.confirmPassword.error
                              as ConfirmedPasswordValidationError)
                          .name
                      : null,
                  isPasswordField: true,
                  onChanged: (confirmPassword) => context
                      .read<RegistrationBloc>()
                      .add(ConfirmPasswordChanged(
                          confirmPassword: confirmPassword)),
                  keyboardType: TextInputType.visiblePassword)),
        );
      },
    );
  }
}

class RegistrNextButton extends StatefulWidget {
  final TabController tabController;
  RegistrNextButton({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<RegistrNextButton> createState() => _RegistrNextButtonState();
}

class _RegistrNextButtonState extends State<RegistrNextButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
          child: FFButtonWidget(
            onPressed: () {
              state.status.isValidated
                  ? setState(() {
                      widget.tabController.index = 1;
                    })
                  : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Enter correct data',
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Colors.redAccent,
                    ));
            },
            text: 'Next',
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

class RegistrFinalButton extends StatelessWidget {
  const RegistrFinalButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegState>(
      buildWhen: ((previous, current) {
        return previous.status != current.status ||
            previous.dateOfBirth != current.dateOfBirth ||
            previous.childImageId != current.childImageId;
      }),
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
          child: FFButtonWidget(
            onPressed: () {
              state.status.isValidated &&
                      state.childImageId.value.isNotEmpty &&
                      state.dateOfBirth.value.isNotEmpty
                  ? context.read<RegistrationBloc>().add(ChildFormSubmitted())
                  : errorMsg(context);
            },
            text: 'Register',
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

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> errorMsg(
      BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Enter correct data',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.redAccent,
    ));
  }
}

class _BackButton extends StatefulWidget {
  final TabController tabController;
  const _BackButton({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<_BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<_BackButton> {
  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: () {
        // widget.tabController.index == 1
        //     ?
        setState(() => widget.tabController.index = 0);
        // : Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => WelcomeWidget(),
        //     ),
        //     (r) => false,
        //   );
      },
      text: 'Back',
      options: FFButtonOptions(
        width: 360.w,
        height: 60.h,
        color: Color(0xFF9BA1A4),
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
}

class BirthField extends StatelessWidget {
  const BirthField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegState>(
      buildWhen: (previous, current) =>
          previous.dateOfBirth != current.dateOfBirth,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(25, 92, 25, 92),
          child: Container(
            width: 378.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: AuthDateField(
              initialDate: DateTime.tryParse(state.dateOfBirth.value),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              onDateSaved: (dob) {
                context
                    .read<RegistrationBloc>()
                    .add(DateOfBirthChanged(dateOfBirth: dob.toString()));
              },
            ),
          ),
        );
      },
    );
  }
}
