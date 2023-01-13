import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/pages/registration/bloc/reg_event.dart';

import '../pages/registration/bloc/reg_bloc.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({Key? key}) : super(key: key);

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  int selected = 0;
  Country countrySelected = Country(
    phoneCode: '',
    countryCode: '',
    e164Sc: -1,
    geographic: false,
    level: -1,
    name: '',
    example: '',
    displayName: '',
    displayNameNoCountryCode: '',
    e164Key: '',
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.fromSTEB(25, 0, 25, 12),
      child: Container(
          width: 378.w,
          height: 70.h,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: (selected == 0)
              ? initialField(context)
              : InkWell(
                  onTap: () => showCountry(context),
                  child: RowOfFlag(countrySelected: countrySelected))),
    );
  }

  TextFormField initialField(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: () => showCountry(context),
      style: FlutterFlowTheme.of(context)
          .subtitle2
          .override(fontFamily: 'Montserrat', fontSize: 17.sp),
      autovalidateMode: AutovalidateMode.disabled,
      obscureText: false,
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x00000000)),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        labelText: 'Select Country',
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
        contentPadding: REdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
      ),
    );
  }

  void showCountry(BuildContext context) {
    return showCountryPicker(
      context: context,
      favorite: <String>['CA'],
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          countrySelected = country;
          selected = 1;
        });
        context
            .read<RegistrationBloc>()
            .add(CountryChanged(country: country.displayNameNoCountryCode));
        print('Select country: ${country.displayNameNoCountryCode}');
      },
      // Optional. Sets the theme for the country list picker.
      countryListTheme: CountryListThemeData(
        textStyle: FlutterFlowTheme.of(context)
            .subtitle2
            .override(fontFamily: 'Montserrat', fontSize: 17.sp),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.r),
          topRight: Radius.circular(40.r),
        ),
        // Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelStyle: FlutterFlowTheme.of(context)
              .subtitle2
              .override(fontFamily: 'Montserrat', fontSize: 17.sp),
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
    );
  }
}

class RowOfFlag extends StatelessWidget {
  RowOfFlag({Key? key, required this.countrySelected}) : super(key: key);
  final Country countrySelected;
  @override
  Widget build(BuildContext context) {
    final TextStyle _textStyle = FlutterFlowTheme.of(context)
        .subtitle2
        .override(fontFamily: 'Montserrat', fontSize: 17.sp);

    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Material(
      // Add Material Widget with transparent color
      // so the ripple effect of InkWell will show on tap
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: <Widget>[
            Row(
              children: [
                const SizedBox(width: 20),
                _flagWidget(countrySelected, context),
                const SizedBox(width: 15),
              ],
            ),
            Expanded(
              child: Text(
                CountryLocalizations.of(context)
                        ?.countryName(countryCode: countrySelected.countryCode)
                        ?.replaceAll(RegExp(r"\s+"), " ") ??
                    countrySelected.name,
                style: _textStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _flagWidget(Country country, context) {
  final bool isRtl = Directionality.of(context) == TextDirection.rtl;

  return SizedBox(
    // the conditional 50 prevents irregularities caused by the flags in RTL mode
    width: isRtl ? 50 : null,
    child: Text(
      Utils.countryCodeToEmoji(country.countryCode),
      style: TextStyle(
        fontSize: 25,
      ),
    ),
  );
}

class Utils {
  static String countryCodeToEmoji(String countryCode) {
    // 0x41 is Letter A
    // 0x1F1E6 is Regional Indicator Symbol Letter A
    // Example :
    // firstLetter U => 20 + 0x1F1E6
    // secondLetter S => 18 + 0x1F1E6
    // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }
}
