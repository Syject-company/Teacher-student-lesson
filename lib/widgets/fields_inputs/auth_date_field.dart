import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/widgets/fields_inputs/dob_input.dart';

class AuthDateField extends StatefulWidget {
  final String label;
  final ValueChanged<DateTime> onDateSaved;
  // final String? error;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;

  AuthDateField({
    Key? key,
    this.label = '',
    required this.onDateSaved,
    // this.error,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
  }) : super(key: key);

  @override
  State<AuthDateField> createState() => _AuthDateFieldState();
}

class _AuthDateFieldState extends State<AuthDateField> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DOBInputField(
      initialDate: (widget.initialDate != null) ? widget.initialDate : null,
      style: FlutterFlowTheme.of(context)
          .subtitle2
          .override(fontFamily: 'Montserrat', fontSize: 17.sp),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onDateSubmitted: widget.onDateSaved,
      inputDecoration: InputDecoration(
        // errorText: 'Enter Date in Valid Format',
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x00000000)),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        labelText: ' Date of Birth MM/DD/YYYY',
        labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'Montserrat', color: Color(0xFF95A1AC), fontSize: 14),
        counterText: '',
        hintStyle: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'Montserrat', color: Color(0xFF95A1AC), fontSize: 14),
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
        contentPadding: REdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      ),
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );
  }
}
