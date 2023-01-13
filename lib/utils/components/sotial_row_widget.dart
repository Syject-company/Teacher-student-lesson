import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SotialRowWidget extends StatefulWidget {
  const SotialRowWidget({Key? key}) : super(key: key);

  @override
  _SotialRowWidgetState createState() => _SotialRowWidgetState();
}

class _SotialRowWidgetState extends State<SotialRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFF5F6FA),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Color(0x3314181B),
                  offset: Offset(0, 2),
                )
              ],
              shape: BoxShape.circle,
            ),
            alignment: AlignmentDirectional(0, 0),
            child: FaIcon(
              FontAwesomeIcons.google,
              color: Color(0xFF423F3F),
              size: 24,
            ),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFF5F6FA),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Color(0x3314181B),
                  offset: Offset(0, 2),
                )
              ],
              shape: BoxShape.circle,
            ),
            alignment: AlignmentDirectional(0, 0),
            child: FaIcon(
              FontAwesomeIcons.apple,
              color: Color(0xFF423F3F),
              size: 24,
            ),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFF5F6FA),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Color(0x3314181B),
                  offset: Offset(0, 2),
                )
              ],
              shape: BoxShape.circle,
            ),
            alignment: AlignmentDirectional(0, 0),
            child: FaIcon(
              FontAwesomeIcons.facebookF,
              color: Color(0xFF423F3F),
              size: 24,
            ),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFF5F6FA),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Color(0x3314181B),
                  offset: Offset(0, 2),
                )
              ],
              shape: BoxShape.circle,
            ),
            alignment: AlignmentDirectional(0, 0),
            child: Icon(
              Icons.phone_sharp,
              color: Color(0xFF423F3F),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
