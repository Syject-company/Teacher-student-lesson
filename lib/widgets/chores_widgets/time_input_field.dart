import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/pages/parent_pages/chores_page/bloc/chores_bloc.dart';

class TimeInputField extends StatefulWidget {
  // final ChoresState state;
  const TimeInputField({
    Key? key,
    // required this.state,
  }) : super(key: key);

  @override
  _TimeInputFieldState createState() => _TimeInputFieldState();
}

class _TimeInputFieldState extends State<TimeInputField> {
  String hrCounter = '00';
  String minCounter = '00';
  String temp = "";

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChoresBloc, ChoresState>(
      buildWhen: (previous, current) => previous.time != current.time,
      builder: (context, state) {
        if (controller.text.isEmpty) {
          controller.text = state.time.value;
          print(state.time.value);
        }

        return TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: false),
          inputFormatters: [
            LengthLimitingTextInputFormatter(6),
          ],
          decoration: InputDecoration(
              hintText: '$hrCounter:$minCounter',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: 'Enter Time HH:MM',
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x00000000)),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF95A1AC),
                  fontSize: 14),
              counterText: '',
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
              contentPadding: REdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              errorText:
                  state.time.error == null ? null : state.time.error?.name),
          onFieldSubmitted: (time) {
            print(time);
            context.read<ChoresBloc>().add(ChoresTimeChanged(time: time));
          },
          onChanged: (val) {
            print(val);
            String y = "";
            switch (val.length) {
              case 0:
                setState(() {
                  hrCounter = "00";
                  minCounter = "00";
                });
                break;
              case 1:
                setState(() {
                  minCounter = "0" + val;
                  temp = val;
                  controller.value = controller.value.copyWith(
                    text: hrCounter + ":" + minCounter,
                    selection: const TextSelection.collapsed(offset: 5),
                  );
                });
                break;
              case 2:
                setState(() {
                  hrCounter = "00";
                  minCounter = "00";
                  controller.value = controller.value.copyWith(
                    text: hrCounter + ":" + minCounter,
                    selection: const TextSelection.collapsed(offset: 5),
                  );
                });
                break;
              case 3:
                setState(() {
                  hrCounter = "00";
                  minCounter = "00";
                  controller.value = controller.value.copyWith(
                    text: hrCounter + ":" + minCounter,
                    selection: const TextSelection.collapsed(offset: 5),
                  );
                });
                break;
              case 4:
                setState(() {
                  hrCounter = "00";
                  minCounter = "00";
                  controller.value = controller.value.copyWith(
                    text: hrCounter + ":" + minCounter,
                    selection: const TextSelection.collapsed(offset: 5),
                  );
                });
                break;
              default:
                setState(() {
                  for (int i = 1; i <= val.length - 1; i++) {
                    y = y + val.substring(i, i + 1);
                  }
                  y = y.replaceAll(":", "");
                  val = y.substring(0, 2) + ":" + y.substring(2, 4);

                  temp = val;
                  controller.value = controller.value.copyWith(
                    text: val,
                    selection: const TextSelection.collapsed(offset: 5),
                  );
                });
                break;
            }
          },
        );
      },
    );
  }
}
