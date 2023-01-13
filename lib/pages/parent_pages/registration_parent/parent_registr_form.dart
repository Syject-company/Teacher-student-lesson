import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/flutter_flow/flutter_flow_widgets.dart';
import 'package:tutor/pages/registration/bloc/reg_bloc.dart';
import 'package:tutor/pages/registration/bloc/reg_event.dart';
import 'package:tutor/pages/registration/bloc/reg_state.dart';
import 'package:tutor/pages/registration/fields/confirm_password.dart';
import 'package:tutor/pages/registration/fields/email.dart';
import 'package:tutor/pages/registration/fields/password.dart';
import 'package:tutor/pages/child_pages/registration_child/child_registration_widget.dart';
import 'package:tutor/utils/validators/email_validator.dart';
import 'package:tutor/pages/welcome/welcome_widget.dart';

import 'package:tutor/widgets/country_pick.dart';
import 'package:tutor/widgets/fields_inputs/auth_text_field.dart';

class RegistrForm extends StatelessWidget {
  RegistrForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            _msg(context, state.errorMessage);
          } else if (state.status.isSubmissionSuccess) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChildRegistrationWidget()));
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopScreen(),
              RegistrationTitle(),
              EmailField(),
              NameField(),
              PasswordField(),
              ConfirmPasswordField(),
              SelectCountry(),
              RegistrButton(),
              _BackButton(),
            ],
          ),
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

class RegistrationTitle extends StatelessWidget {
  const RegistrationTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.fromSTEB(0, 35, 0, 30),
      child: Text(
        'Parent Registration',
        textAlign: TextAlign.center,
        style: FlutterFlowTheme.of(context).title2,
      ),
    );
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
          padding: REdgeInsetsDirectional.fromSTEB(25, 12, 25, 12),
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
          padding: REdgeInsetsDirectional.fromSTEB(25, 0, 25, 12),
          child: Container(
              width: 378.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: AuthTextField(
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
          padding: REdgeInsetsDirectional.fromSTEB(25, 0, 25, 12),
          child: Container(
              width: 378.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: AuthTextField(
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

class RegistrButton extends StatelessWidget {
  const RegistrButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.country != current.country,
      builder: (context, state) {
        return Padding(
          padding: REdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
          child: FFButtonWidget(
            onPressed: () async {
              print(state.country.value);
              if (state.status.isValidated && state.country.value.isNotEmpty) {
                context.read<RegistrationBloc>().add(FormSubmitted());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Enter correct data',
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.redAccent,
                ));
              }
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
}

class _BackButton extends StatelessWidget {
  const _BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: () async {
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeWidget(),
          ),
          (r) => false,
        );
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
