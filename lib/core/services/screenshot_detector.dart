import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ScreenshotDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback onScreenshotDetected;

  const ScreenshotDetector({
    super.key,
    required this.child,
    required this.onScreenshotDetected,
  });

  @override
  State<ScreenshotDetector> createState() => _ScreenshotDetectorState();
}

class _ScreenshotDetectorState extends State<ScreenshotDetector> {
  final List<Duration> _frameTimes = [];
  static const int _framesToDetect = 3;
  static const int _maxFrameTimeDiff = 16; // milliseconds

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addTimingsCallback(_handleTimings);
  }

  @override
  void dispose() {
    SchedulerBinding.instance.removeTimingsCallback(_handleTimings);
    super.dispose();
  }

  void _handleTimings(List<FrameTiming> timings) {
    final now = DateTime.now();
    _frameTimes.add(Duration(milliseconds: now.millisecondsSinceEpoch));

    // Keep only recent frame times
    if (_frameTimes.length > _framesToDetect) {
      _frameTimes.removeAt(0);
    }

    // Check for identical frame times (screenshot indicator)
    if (_frameTimes.length == _framesToDetect) {
      final diff1 = _frameTimes[1].inMilliseconds - _frameTimes[0].inMilliseconds;
      final diff2 = _frameTimes[2].inMilliseconds - _frameTimes[1].inMilliseconds;

      if (diff1 < _maxFrameTimeDiff && diff2 < _maxFrameTimeDiff) {
        widget.onScreenshotDetected();
        _frameTimes.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}