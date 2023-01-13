import 'package:flutter/material.dart';

class AutButtonWidget extends StatelessWidget {
  const AutButtonWidget({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final Widget icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // color: Color(0xFF8E8E93),
          color: Color(0xFFEDEDED),
        ),
        width: 60.0,
        height: 60.0,
        child: icon,
      ),
    );
  }
}
