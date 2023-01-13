import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_icon_button.dart';

class AddButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData? icon;
  const AddButton({
    Key? key,
    required this.controller,
    this.onPressed,
    this.icon,
  }) : super(key: key);

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return FlutterFlowIconButton(
      borderColor: Colors.transparent,
      borderRadius: 100.r,
      fillColor: Color.fromRGBO(217, 217, 217, 1),
      buttonSize: 44.h,
      icon: Icon(
        icon ?? Icons.add,
        size: 22.h,
        color: Colors.black,
      ),
      onPressed: onPressed,
    );
  }
}
