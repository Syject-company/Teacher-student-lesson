import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor/flutter_flow/flutter_flow_icon_button.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/flutter_flow/flutter_flow_widgets.dart';

class BottomsheetWidget extends StatefulWidget {
  const BottomsheetWidget({Key? key}) : super(key: key);

  @override
  _BottomsheetWidgetState createState() => _BottomsheetWidgetState();
}

class _BottomsheetWidgetState extends State<BottomsheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 428.w,
      height: 312.h,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 1,
                    buttonSize: 60,
                    icon: Icon(
                      Icons.close,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 30,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Padding(
                padding: REdgeInsetsDirectional.fromSTEB(47, 0, 107, 0),
                child: Text(
                  'Login and restore data ',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          Text(
            'Click here if you have login details',
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
          ),
          FFButtonWidget(
            onPressed: () {
              print('Button pressed ...');
            },
            text: 'Sign in with Apple',
            icon: FaIcon(
              FontAwesomeIcons.apple,
              size: 20,
            ),
            options: FFButtonOptions(
              width: 378.w,
              height: 40.h,
              color: Colors.black,
              textStyle: GoogleFonts.getFont(
                'Montserrat',
                color: FlutterFlowTheme.of(context).primaryBtnText,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              elevation: 4,
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Container(
              width: 378.w,
              height: 50.h,
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'Sign in with Google',
                      icon: Icon(
                        Icons.add,
                        color: Colors.transparent,
                        size: 20,
                      ),
                      options: FFButtonOptions(
                        width: 378.w,
                        height: 40.h,
                        color: Color(0xFF868686),
                        textStyle: GoogleFonts.getFont(
                          'Montserrat',
                          color: Color(0xFF606060),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        elevation: 4,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.44, 0.15),
                    child: Container(
                      width: 22.w,
                      height: 22.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        'https://i0.wp.com/nanophorm.com/wp-content/uploads/2018/04/google-logo-icon-PNG-Transparent-Background.png?w=1000&ssl=1',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Container(
              width: 378.w,
              height: 50.h,
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'Sign in with Mail',
                      icon: Icon(
                        Icons.mail_rounded,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        size: 20,
                      ),
                      options: FFButtonOptions(
                        width: 378.w,
                        height: 40.h,
                        color: Color(0xFF868686),
                        textStyle: GoogleFonts.getFont(
                          'Montserrat',
                          color: Color(0xFF606060),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        elevation: 4,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
