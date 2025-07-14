import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class ScreenshotPreventer {
  static const MethodChannel _channel = MethodChannel('screenshot_channel');
  static bool _initialized = false;

  static Future<void> _ensureInitialized() async {
    if (!_initialized) {
      try {
        await _channel.invokeMethod('initialize');
        _initialized = true;
      } catch (e) {
        debugPrint("ScreenshotPreventer initialization failed: $e");
      }
    }
  }

  static Future<bool> preventScreenshots() async {
    try {
      await _ensureInitialized();
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
        return await _channel.invokeMethod('preventScreenshots') ?? false;
      }
      return false;
    } on PlatformException catch (e) {
      debugPrint("Failed to prevent screenshots: ${e.message}");
      return false;
    }
  }

  static Future<bool> allowScreenshots() async {
    try {
      await _ensureInitialized();
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
        return await _channel.invokeMethod('allowScreenshots') ?? false;
      }
      return false;
    } on PlatformException catch (e) {
      debugPrint("Failed to allow screenshots: ${e.message}");
      return false;
    }
  }
}