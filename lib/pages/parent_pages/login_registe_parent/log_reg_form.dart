import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/constants/icons.dart';

import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/navigation/child_nav_page.dart';
import 'package:tutor/navigation/parent_nav_page.dart';
import 'package:tutor/pages/login/bloc/login_bloc.dart';
import 'package:tutor/pages/registration/fields/email.dart';
import 'package:tutor/pages/registration/fields/password.dart';
import 'package:tutor/flutter_flow/flutter_flow_widgets.dart';
import 'package:tutor/pages/forgot_password/forgot_password_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/widgets/fields_inputs/auth_text_field.dart';
import 'package:tutor/widgets/reg_widget/reg_title.dart';
import 'package:tutor/widgets/reg_widget/sign_up.dart';
import 'package:tutor/widgets/reg_widget/title_with_image.dart';

class Log_reg_form extends StatefulWidget {
  const Log_reg_form({
    Key? key,
  }) : super(key: key);

  @override
  State<Log_reg_form> createState() => _Log_reg_formState();
}

class _Log_reg_formState extends State<Log_reg_form>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passChildController = TextEditingController();
  final _emailChildController = TextEditingController();
  late TabController _tabController;
  IconData? iconP = TabIcon.group_448;
  IconData? iconC = TabIcon.ellipse_7;
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
    _tabController.addListener(() {
      setState(() {
        switch (_tabController.index) {
          case 0:
            iconP = TabIcon.group_448;
            iconC = TabIcon.ellipse_7;
            break;
          case 1:
            iconP = TabIcon.ellipse_7;
            iconC = TabIcon.group_448;
        }
      });
    });
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Colors.red,
          ));
        } else if (state is LoginSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => NavBarPage(initialPage: 'HomePage')));
        } else if (state is LoginChildSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ChildNavBarPage(initialPage: 'HomePage')));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleWithImage(),
          RegTitleText(
            text: 'Log In',
          ),
          Expanded(
            child: Column(
              children: [
                TabBarParentChild(
                    tabController: _tabController, iconP: iconP, iconC: iconC),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ParentTabView(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        tabController: _tabController,
                      ),
                      ChildTabView(
                        emailController: _emailChildController,
                        passwordController: _passChildController,
                        tabController: _tabController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChildTabView extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TabController tabController;
  const ChildTabView({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EmailField(
              emailLable: 'EmailChild',
              emailController: emailController,
            ),
            PasswordField(
              passwordLable: 'PasswordChild',
              passwordController: passwordController,
            ),
            ForgotPassword(index: tabController.index),
            _LoginButton(
              isParent: false,
              emailController: emailController,
              passwordController: passwordController,
            ),
            SignUp(),
          ],
        ),
      ),
    );
  }
}

class ParentTabView extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TabController tabController;

  const ParentTabView({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(tabController.index);
    return Padding(
      padding: REdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EmailField(
              emailLable: 'EmailParent',
              emailController: emailController,
            ),
            PasswordField(
              passwordLable: 'PasswordParent',
              passwordController: passwordController,
            ),
            ForgotPassword(
              index: tabController.index,
            ),
            _LoginButton(
              isParent: true,
              emailController: emailController,
              passwordController: passwordController,
            ),
            SignUp(),
          ],
        ),
      ),
    );
  }
}

class TabBarParentChild extends StatelessWidget {
  const TabBarParentChild({
    Key? key,
    required TabController tabController,
    required this.iconP,
    required this.iconC,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final IconData? iconP;
  final IconData? iconC;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: Colors.black,
      unselectedLabelColor: Color(0xFF868686),
      labelStyle: FlutterFlowTheme.of(context).subtitle2,
      indicatorColor: Colors.white,
      tabs: [
        Row(
          children: [
            Padding(
                padding: REdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                child: Icon(iconP, color: Color(0xFF2BC0EF))),
            Tab(text: 'Parent'),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: REdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
              child: Icon(iconC, color: Color(0xFF2BC0EF)),
            ),
            Tab(text: 'Child'),
          ],
        ),
      ],
    );
  }
}

class EmailField extends StatelessWidget {
  final emailLable;

  final TextEditingController emailController;
  EmailField({
    Key? key,
    required this.emailLable,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(0, 14, 0, 17),
          child: Container(
              width: 378.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: AuthTextField(
                  controller: emailController,
                  label: emailLable,
                  error: state.email.error != null
                      ? (state.email.error as EmailValidationError).title
                      : null,
                  isPasswordField: false,
                  onChanged: (email) =>
                      context.read<LoginBloc>().add(EmailChanged(email: email)),
                  keyboardType: TextInputType.emailAddress)),
        );
      },
    );
  }
}

class PasswordField extends StatelessWidget {
  final passwordLable;
  final TextEditingController passwordController;
  PasswordField({
    Key? key,
    required this.passwordLable,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.email != current.email,
      builder: (context, state) {
        return Container(
            width: 378.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: AuthTextField(
              controller: passwordController,
              error: state.password.error != null
                  ? (state.password.error as PasswordValidationError).title
                  : null,
              label: passwordLable,
              keyboardType: TextInputType.visiblePassword,
              isPasswordField: true,
              onChanged: (pass) => context
                  .read<LoginBloc>()
                  .add(PasswordChanged(password: pass)),
            ));
      },
    );
  }
}

class ForgotPassword extends StatelessWidget {
  final int index;
  const ForgotPassword({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.fromSTEB(0, 0, 0, 110.sp),
      child: FFButtonWidget(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForgotPasswordWidget(parentIndex: index),
            ),
          );
        },
        text: 'Forgot Password?',
        options: FFButtonOptions(
          color: Color(0x0039D2C0),
          textStyle: FlutterFlowTheme.of(context).subtitle1.override(
                fontFamily: 'Montserrat',
                color: Color(0xFF868686),
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
          elevation: 0,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
        ),
        showLoadingIndicator: false,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final isParent;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  _LoginButton({
    Key? key,
    required this.isParent,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return FFButtonWidget(
          onPressed: () {
            if (state is! LoginLoading) {
              BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
                isParent: isParent,
                email: emailController.text,
                password: passwordController.text,
              ));
            } else {
              null;
            }
          },
          text: 'Log In',
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
