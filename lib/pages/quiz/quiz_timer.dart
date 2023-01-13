import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';

class CountUpTimer extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<CountUpTimer> {
  final StopWatchTimer _stopWatchTimer =
      StopWatchTimer(mode: StopWatchMode.countUp);

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.onStartTimer();
    _stopWatchTimer.rawTime.listen((value) =>
        StopWatchTimer.getDisplayTime(value) == '00:60:00.00'
            ? _stopWatchTimer.onStopTimer()
            : () {});
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _stopWatchTimer.rawTime,
      initialData: _stopWatchTimer.rawTime.value,
      builder: (context, snap) {
        final value = snap.data!;
        final displayTime = StopWatchTimer.getDisplayTime(value,
            hours: false, milliSecond: false, minute: true, second: true);
        return Text(
          displayTime,
          style: FlutterFlowTheme.of(context).subtitle2.override(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize: 50.sp,
                fontWeight: FontWeight.w700,
              ),
        );
      },
    );
  }
}
