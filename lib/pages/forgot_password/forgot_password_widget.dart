import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:tutor/authication/bloc/authentication_bloc.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/flutter_flow/flutter_flow_widgets.dart';
import 'package:tutor/pages/forgot_password/bloc/recovery_bloc.dart';
import 'package:tutor/pages/parent_pages/login_registe_parent/login_registe_parent_widget.dart';
import 'package:tutor/pages/registration/fields/code.dart';
import 'package:tutor/pages/registration/fields/confirm_password.dart';
import 'package:tutor/pages/registration/fields/email_recovery.dart';
import 'package:tutor/pages/registration/fields/password.dart';
import 'package:tutor/utils/repository/user_repository.dart';
import 'package:tutor/widgets/fields_inputs/auth_text_field.dart';
import 'package:tutor/widgets/reg_widget/reg_title.dart';
import 'package:tutor/widgets/reg_widget/sign_up.dart';
import 'package:tutor/widgets/reg_widget/title_with_image.dart';

class ForgotPasswordWidget extends StatefulWidget {
  final int? parentIndex;
  const ForgotPasswordWidget({Key? key, this.parentIndex}) : super(key: key);

  @override
  _ForgotPasswordWidgetState createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget>
    with SingleTickerProviderStateMixin {
  late TextEditingController forgotEmailController;
  late TabController forgotController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    forgotController = TabController(length: 2, vsync: this);
    forgotEmailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecoveryBloc(
        userRepository: UserRepository(),
      ),
      child: BlocListener<RecoveryBloc, RecoveryState>(
        listener: (context, state) {
          if (state is ForgotPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ));
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginRegisteParentWidget(
                        userRepository: UserRepository())));
          } else if (state is MailSendedSuccess) {
            forgotController.index = 1;
          } else if (state is PassSendedSuccess) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginRegisteParentWidget(
                        userRepository: UserRepository())));
          }
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleWithImage(),
              RegTitleText(text: 'Forgot Password'),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        controller: forgotController,
                        children: [
                          EmailTabView(
                            forgotEmailController: forgotEmailController,
                            tabController: forgotController,
                            parentIndex: widget.parentIndex ?? 0,
                          ),
                          CodeTabView(
                            parentIndex: widget.parentIndex ?? 0,
                            forgotEmailController: forgotEmailController,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailTabView extends StatelessWidget {
  final TabController tabController;
  final TextEditingController forgotEmailController;
  final int parentIndex;

  const EmailTabView({
    Key? key,
    required this.forgotEmailController,
    required this.tabController,
    required this.parentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ForgotEmailField(
              emailLable: 'EmailParent',
              emailController: forgotEmailController,
            ),
            RecieveButton(
              parentIndex: parentIndex,
              emailController: forgotEmailController,
            ),
            SignUp(),
          ],
        ),
      ),
    );
  }
}

class RecieveButton extends StatelessWidget {
  final int parentIndex;
  final TextEditingController emailController;

  RecieveButton({
    Key? key,
    required this.parentIndex,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoveryBloc, RecoveryState>(
      builder: (context, state) {
        return FFButtonWidget(
          onPressed: () {
            if (state.status.isValidated && emailController.text.isNotEmpty) {
              BlocProvider.of<RecoveryBloc>(context).add(GetCodePressed(
                parentIndex: parentIndex,
              ));
            }
          },
          text: 'Receive a letter',
          options: FFButtonOptions(
            width: 360.w,
            height: 60.h,
            color: state.status.isValid && emailController.text.isNotEmpty
                ? Color(0xFF2BC0EF)
                : Colors.grey,
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

class CodeTabView extends StatelessWidget {
  final int? parentIndex;
  final TextEditingController forgotEmailController;
  const CodeTabView({
    Key? key,
    required this.forgotEmailController,
    this.parentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CodeField(emailLable: 'Code From Email'),
            NewPasswordField(),
            ConfirmNewPasswordField(),
            SendCodeButton(
                parentIndex: parentIndex ?? 0,
                forgotEmailController: forgotEmailController),
            SignUp(),
          ],
        ),
      ),
    );
  }
}

class SendCodeButton extends StatelessWidget {
  final TextEditingController forgotEmailController;
  final int parentIndex;

  SendCodeButton({
    Key? key,
    required this.parentIndex,
    required this.forgotEmailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoveryBloc, RecoveryState>(
      builder: (context, state) {
        return FFButtonWidget(
          onPressed: () {
            print(state.forgotEmail);
            BlocProvider.of<RecoveryBloc>(context).add(SendPasswordPressed(
                forgotEmail: forgotEmailController.text,
                parentIndex: parentIndex));
          },
          text: 'Send Code',
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

class CodeField extends StatelessWidget {
  final emailLable;

  final TextEditingController? codeController;
  CodeField({Key? key, required this.emailLable, this.codeController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoveryBloc, RecoveryState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(25, 28, 25, 0),
          child: Container(
              width: 378.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: AuthTextField(
                  controller: codeController,
                  label: emailLable,
                  error: state.code.error != null
                      ? (state.code.error as CodeError).title
                      : null,
                  isPasswordField: false,
                  onChanged: (code) =>
                      context.read<RecoveryBloc>().add(CodeChanged(code: code)),
                  keyboardType: TextInputType.emailAddress)),
        );
      },
    );
  }
}

class ForgotEmailField extends StatelessWidget {
  final emailLable;

  final TextEditingController emailController;
  ForgotEmailField({
    Key? key,
    required this.emailLable,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoveryBloc, RecoveryState>(
      buildWhen: (previous, current) =>
          previous.forgotEmail != current.forgotEmail,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(25, 28, 25, 198),
          child: Container(
              width: 378.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: AuthTextField(
                  controller: emailController,
                  label: emailLable,
                  error: state.forgotEmail.error != null
                      ? (state.forgotEmail.error
                              as EmailRecoveryValidationError)
                          .title
                      : null,
                  isPasswordField: false,
                  onChanged: (email) => context
                      .read<RecoveryBloc>()
                      .add(ForgotEmailChanged(forgotEmail: email)),
                  keyboardType: TextInputType.emailAddress)),
        );
      },
    );
  }
}

class ConfirmNewPasswordField extends StatelessWidget {
  const ConfirmNewPasswordField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoveryBloc, RecoveryState>(
      buildWhen: (previous, current) =>
          previous.newPassword != current.newPassword ||
          previous.confirmNewPassword != current.confirmNewPassword,
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
                  initialValue: state.confirmNewPassword.value,
                  label: 'Confirm New Password',
                  error: state.confirmNewPassword.error != null
                      ? (state.confirmNewPassword.error
                              as ConfirmedPasswordValidationError)
                          .name
                      : null,
                  isPasswordField: true,
                  onChanged: (confirmNewPassword) => context
                      .read<RecoveryBloc>()
                      .add(ConfirmNewPasswordChanged(
                          confirmNewPassword: confirmNewPassword)),
                  keyboardType: TextInputType.visiblePassword)),
        );
      },
    );
  }
}

class NewPasswordField extends StatelessWidget {
  const NewPasswordField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoveryBloc, RecoveryState>(
      buildWhen: (previous, current) =>
          previous.newPassword != current.newPassword,
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
                  initialValue: state.newPassword.value,
                  label: 'New Password',
                  error: state.newPassword.error != null
                      ? (state.newPassword.error as PasswordValidationError)
                          .title
                      : null,
                  isPasswordField: true,
                  onChanged: (password) => context
                      .read<RecoveryBloc>()
                      .add(NewPasswordChanged(newPassword: password)),
                  keyboardType: TextInputType.visiblePassword)),
        );
      },
    );
  }
}
// EnterCodeNotNowWidget()
// 'Receive a letter'