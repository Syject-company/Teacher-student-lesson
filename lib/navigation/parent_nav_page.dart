import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/flutter_flow/flutter_flow_util.dart';
import 'package:tutor/pages/parent_pages/chores_page/chores_page_widget.dart';
import 'package:tutor/pages/parent_pages/home_page/home_page_widget.dart';
import 'package:tutor/pages/parent_pages/lessons_page/lessons_page_widget.dart';
import 'package:tutor/pages/parent_pages/rewards_page/rewards_page_widget.dart';
import 'package:tutor/pages/parent_pages/setting_page/setting_page_widget.dart';

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.wentToindex}) : super(key: key);
  final int? wentToindex;
  final String? initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'HomePage';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    double buttonFontSise = 16;
    double buttonIconSize = 46.h;
    double bluePadding = 10;
    final tabs = {
      'HomePage': HomePageWidget(),
      'LessonsPage': LessonsPageWidget(),
      'RewardsPage': RewardsPageWidget(),
      'ChoresPage': ChoresPageWidget(),
      'SettingPage': SettingPageWidget(
        wentToindex: widget.wentToindex,
        isChild: false,
      ),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPage);
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ]),
        child: GNav(
          selectedIndex: currentIndex,
          onTabChange: (i) =>
              setState(() => _currentPage = tabs.keys.toList()[i]),
          backgroundColor: Colors.white,
          color: Color(0x8A000000),
          activeColor: FlutterFlowTheme.of(context).secondaryBackground,
          tabBackgroundColor: Color(0x00000000),
          tabBorderRadius: 80.r,
          tabMargin: REdgeInsetsDirectional.fromSTEB(0, 27, 0, 27),
          // padding: REdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
          gap: 1.sp,
          mainAxisAlignment: MainAxisAlignment.center,
          // duration: Duration(milliseconds: 500),
          haptic: false,
          tabs: [
            GButton(
              padding: REdgeInsets.symmetric(horizontal: bluePadding),
              icon: FFIcons.kframe4341,
              text: 'Home',
              textStyle: GoogleFonts.getFont(
                'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: buttonFontSise,
              ),
              iconSize: buttonIconSize,
              backgroundColor: Color(0xFF2BC0EF),
            ),
            GButton(
              padding: REdgeInsets.symmetric(horizontal: bluePadding),
              icon: FFIcons.kframe4344,
              text: 'Lessons',
              textStyle: GoogleFonts.getFont(
                'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: buttonFontSise,
              ),
              iconSize: buttonIconSize,
              backgroundColor: Color(0xFF2BC0EF),
            ),
            GButton(
              padding: REdgeInsets.symmetric(horizontal: bluePadding),
              icon: FFIcons.kframe4345,
              text: 'Rewards',
              textStyle: GoogleFonts.getFont(
                'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: buttonFontSise,
              ),
              iconSize: buttonIconSize,
              backgroundColor: Color(0xFF2BC0EF),
            ),
            GButton(
              padding: REdgeInsets.symmetric(horizontal: bluePadding),
              icon: FFIcons.kframe4342,
              text: 'Chores',
              textStyle: GoogleFonts.getFont(
                'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: buttonFontSise,
              ),
              iconSize: buttonIconSize,
              backgroundColor: Color(0xFF2BC0EF),
            ),
            GButton(
              padding: REdgeInsets.symmetric(horizontal: bluePadding),
              icon: FFIcons.kframe4343,
              text: 'Settings',
              textStyle: GoogleFonts.getFont(
                'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: buttonFontSise,
              ),
              iconSize: buttonIconSize,
              backgroundColor: Color(0xFF2BC0EF),
            )
          ],
        ),
      ),
    );
  }
}
