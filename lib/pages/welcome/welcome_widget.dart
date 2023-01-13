import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tutor/authication/bloc/authentication_bloc.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/flutter_flow/flutter_flow_widgets.dart';
import 'package:tutor/pages/parent_pages/registration_parent/parent_registration_widget.dart';
//import 'package:tutor/pages/welcome/aurh_servise.dart';
import 'package:tutor/utils/repository/user_repository.dart';
import 'package:tutor/widgets/aut_button_widget.dart';
import '../parent_pages/login_registe_parent/login_registe_parent_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({
    Key? key,
  }) : super(key: key);

  @override
  _WelcomeWidgetState createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoggedIn = false;
  Map _userObi = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                  height: 293.h,
                  width: 169.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: REdgeInsetsDirectional.fromSTEB(0, 65, 0, 21),
              child: Text(
                'Welcome!',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).title2,
              ),
            ),
            Padding(
              padding: REdgeInsetsDirectional.fromSTEB(0, 0, 0, 70),
              child: Text(
                'Raise a future\n businessman!',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: FlutterFlowTheme.of(context).bodyText1,
              ),
            ),
            FFButtonWidget(
              onPressed: () async {
                await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginRegisteParentWidget(
                      userRepository: UserRepository(),
                    ),
                  ),
                  (r) => false,
                );
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
            ),
            Padding(
              padding: REdgeInsetsDirectional.fromSTEB(0, 20, 0, 30),
              child: FFButtonWidget(
                onPressed: () async {
                  await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationWidget(),
                    ),
                    (r) => false,
                  );
                },
                text: 'Register',
                options: FFButtonOptions(
                  width: 360.w,
                  height: 60.h,
                  color: Color(0xFFEDEDED),
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF313131),
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: _isLoggedIn == true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_userObi['name']),
                            Text(_userObi['email']),
                            TextButton(
                                onPressed: () {
                                  FacebookAuth.instance.logOut().then(
                                    (value) {
                                      setState(() {
                                        _isLoggedIn = false;
                                        _userObi = {};
                                      });
                                    },
                                  );
                                },
                                child: Text('Logout'))
                          ],
                        )
                      : Center(
                          child: AutButtonWidget(
                            icon: SvgPicture.asset(
                              'assets/images/aut_facebook.svg',
                              width: 133.w,
                              height: 123.h,
                              fit: BoxFit.scaleDown,
                            ),
                            onPressed: () => context
                                .read<AuthenticationBloc>()
                                .add(LogInFacebook()),

                            // async {
                            //   FacebookAuth.instance.login(permissions: [
                            //     'public_profile'
                            //         'email'
                            //   ]).then((value) {
                            //     FacebookAuth.instance
                            //         .getUserData()
                            //         .then((userData) async {
                            //       setState(() {
                            //         _isLoggedIn = true;
                            //         _userObi = userData;
                            //       });
                            //     });
                            //   });
                            // }
                          ),
                        ),
                ),
                SizedBox(width: 20),
                AutButtonWidget(
                  icon: SvgPicture.asset(
                    'assets/images/aut_googol.svg',
                    width: 133.w,
                    height: 123.h,
                    fit: BoxFit.scaleDown,
                  ),
                  onPressed: () =>
                      context.read<AuthenticationBloc>().add(LogInGoogle()),
                  // {
                  //AuthService().signInWithGoogle();
                  //},
                ),
              ],
            ),
            Padding(
              padding: REdgeInsetsDirectional.fromSTEB(44, 20, 44, 36),
              child: Text(
                'By creating an account or signing-in to TUTOR, you agree to our Terms. Learn how TUTOR processes your data in our Privacy Policy and Cookies Policy.',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8E8E93),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
