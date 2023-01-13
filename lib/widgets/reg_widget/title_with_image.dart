import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleWithImage extends StatelessWidget {
  const TitleWithImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 428.w,
      height: (282 / 926).sh,
      decoration: BoxDecoration(
        color: Color(0xFF2BC0EF),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: REdgeInsetsDirectional.fromSTEB(0, 51.sp, 0, 0),
        child: SvgPicture.asset(
          'assets/images/Group_426.svg',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
