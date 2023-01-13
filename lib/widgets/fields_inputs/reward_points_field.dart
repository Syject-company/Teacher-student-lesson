import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/pages/parent_pages/rewards_page/bloc/rewards_bloc.dart';

class RewardPointInputField extends StatefulWidget {
  const RewardPointInputField({
    Key? key,
  }) : super(key: key);

  @override
  State<RewardPointInputField> createState() => _RewardPointInputFieldState();
}

class _RewardPointInputFieldState extends State<RewardPointInputField> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<int>> _genders = [
      DropdownMenuItem(
        child: Text('10'),
        value: 10,
      ),
      DropdownMenuItem(
        child: Text('20'),
        value: 20,
      ),
      DropdownMenuItem(
        child: Text('30'),
        value: 30,
      ),
      DropdownMenuItem(
        child: Text('40'),
        value: 40,
      ),
      DropdownMenuItem(
        child: Text('50'),
        value: 50,
      ),
      DropdownMenuItem(
        child: Text('60'),
        value: 60,
      ),
      DropdownMenuItem(
        child: Text('70'),
        value: 70,
      ),
      DropdownMenuItem(
        child: Text('80'),
        value: 80,
      ),
      DropdownMenuItem(
        child: Text('90'),
        value: 90,
      ),
      DropdownMenuItem(
        child: Text('100'),
        value: 100,
      )
    ];
    return BlocBuilder<RewardsBloc, RewardsState>(
      buildWhen: (previous, current) =>
          previous.selectedChildren != current.selectedChildren,
      builder: (context, state) {
        var _selectedValue = state.rewardPrice;

        return Container(
          margin: REdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
          width: 378.w,
          height: 70.h,
          child: DropdownButtonFormField<int>(
            decoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x00000000)),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              labelText: 'Select points',
              labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF95A1AC),
                  fontSize: 14),
              hintStyle: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF95A1AC),
                  fontSize: 14),
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
              contentPadding: REdgeInsetsDirectional.fromSTEB(20, 24, 20, 0),
            ),
            isDense: true,
            value: _selectedValue,
            key: const Key('Points'),
            onChanged: (price) {
              setState(() {
                context.read<RewardsBloc>().add(PriceChanged(
                      rewardPrice: price ?? 0,
                    ));
              });
            },
            items: _genders,
          ),
        );
      },
    );
  }
}
