import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';

class AuthTextField extends StatefulWidget {
  final String? Function(String?)? validator;
  final String label;
  void Function()? onTap;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final bool isPasswordField;
  final String? error;
  final TextEditingController? controller;
  final String? initialValue;

  AuthTextField({
    Key? key,
    this.label = '',
    required this.onChanged,
    required this.keyboardType,
    this.isPasswordField = false,
    this.error,
    this.controller,
    this.validator,
    this.initialValue,
    this.onTap,
  }) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool passwordVisibility1;

  void initState() {
    super.initState();
    passwordVisibility1 = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      initialValue: widget.initialValue,
      validator: widget.validator,
      controller: widget.controller,
      style: FlutterFlowTheme.of(context)
          .subtitle2
          .override(fontFamily: 'Montserrat', fontSize: 17.sp),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChanged,
      obscureText: widget.isPasswordField ? !passwordVisibility1 : false,
      decoration: InputDecoration(
        errorText: widget.error,
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x00000000)),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        labelText: widget.label,
        labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'Montserrat', color: Color(0xFF95A1AC), fontSize: 14),
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
        contentPadding: REdgeInsetsDirectional.fromSTEB(20, 44, 20, 0),
        suffixIcon: widget.isPasswordField
            ? InkWell(
                onTap: () =>
                    setState(() => passwordVisibility1 = !passwordVisibility1),
                focusNode: FocusNode(skipTraversal: true),
                child: Icon(
                    passwordVisibility1
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Color(0xFF313131),
                    size: 37.w),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
