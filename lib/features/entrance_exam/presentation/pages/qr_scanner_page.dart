import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../dependencies.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../bloc/entrance_exam_bloc.dart';
import '../bloc/entrance_exam_event.dart';
import '../bloc/entrance_exam_state.dart';
import 'exam_questions_page.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({Key? key}) : super(key: key);

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  MobileScannerController cameraController = MobileScannerController();
  bool isProcessing = false;
  String? lastScannedCode;
  DateTime? lastScanTime;

  static const Duration scanCooldown = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    print('🎥 QR Scanner initialized');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color appBarColor = Colors.blue;
        Color textColor = Colors.white;

        if (themeState is ThemeLoaded) {
          appBarColor = AppThemeHelper.getCardColor(themeState.theme);
          textColor = AppThemeHelper.getTextColor(themeState.theme);
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Scan QR Code'),
            centerTitle: true,
            backgroundColor: appBarColor,
            foregroundColor: textColor,
            actions: [
              IconButton(
                color: textColor,
                icon: ValueListenableBuilder(
                  valueListenable: cameraController.torchState,
                  builder: (context, state, child) {
                    switch (state) {
                      case TorchState.off:
                        return const Icon(Icons.flash_off, color: Colors.white70);
                      case TorchState.on:
                        return const Icon(Icons.flash_on, color: Colors.yellow);
                    }
                  },
                ),
                iconSize: 28.0,
                onPressed: () => cameraController.toggleTorch(),
              ),
              IconButton(
                color: textColor,
                icon: ValueListenableBuilder(
                  valueListenable: cameraController.cameraFacingState,
                  builder: (context, state, child) {
                    switch (state) {
                      case CameraFacing.front:
                        return const Icon(Icons.camera_front);
                      case CameraFacing.back:
                        return const Icon(Icons.camera_rear);
                    }
                  },
                ),
                iconSize: 28.0,
                onPressed: () => cameraController.switchCamera(),
              ),
            ],
          ),
          body: BlocListener<EntranceExamBloc, EntranceExamState>(
            listener: (context, state) {
              print('🔄 QR Scanner state changed: ${state.runtimeType}');
              if (state is ExamStarted) {
                print('✅ Exam started, stopping camera and navigating...');
                cameraController.stop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (context) => getIt<EntranceExamBloc>()..add(LoadExamAttemptEvent(state.attemptId)),
                      child: ExamQuestionsPage(attemptId: state.attemptId),
                    ),
                  ),
                );
              } else if (state is EntranceExamError) {
                print('❌ Error occurred: ${state.message}');
                _resetScanning();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 5),
                    action: SnackBarAction(
                      label: 'Retry',
                      textColor: Colors.white,
                      onPressed: () {
                        _resetScanning();
                      },
                    ),
                  ),
                );
              }
            },
            child: BlocBuilder<EntranceExamBloc, EntranceExamState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    MobileScanner(
                      controller: cameraController,
                      onDetect: _onQrCodeDetected,
                    ),
                    if (state is EntranceExamLoading)
                      Container(
                        color: Colors.black54,
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(height: 16),
                              Text(
                                'Starting exam...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Container(
                      decoration: ShapeDecoration(
                        shape: QrScannerOverlayShape(
                          borderColor: isProcessing ? Colors.orange : Colors.blue,
                          borderRadius: 10,
                          borderLength: 30,
                          borderWidth: 4,
                          cutOutSize: 250,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 100,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Text(
                              isProcessing
                                  ? 'Processing QR code...'
                                  : 'Position the QR code within the frame to start the exam',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 3,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                            if (lastScannedCode != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Last scanned: ${lastScannedCode!.substring(0, lastScannedCode!.length > 8 ? 8 : lastScannedCode!.length)}...',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 3,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (const bool.fromEnvironment('dart.vm.product') == false)
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DEBUG MODE',
                                style: const TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Processing: $isProcessing',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                              Text(
                                'State: ${state.runtimeType}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _onQrCodeDetected(BarcodeCapture capture) {
    if (isProcessing || capture.barcodes.isEmpty) {
      return;
    }

    final String? code = capture.barcodes.first.rawValue;
    if (code == null || code.isEmpty) {
      print('⚠️ Invalid QR code detected: null or empty');
      return;
    }

    final now = DateTime.now();

    if (lastScannedCode == code &&
        lastScanTime != null &&
        now.difference(lastScanTime!) < scanCooldown) {
      print('⏭️ Duplicate scan ignored for code: $code');
      return;
    }

    print('📱 QR Code detected: $code');
    print('🕐 Scan time: $now');

    if (!_isValidQrCode(code)) {
      print('❌ Invalid QR code format: $code');
      _showErrorSnackbar('Invalid QR code format');
      return;
    }

    setState(() {
      isProcessing = true;
      lastScannedCode = code;
      lastScanTime = now;
    });

    cameraController.stop();
    print('🚀 Starting exam with QR code: $code');
    context.read<EntranceExamBloc>().add(StartExamByQrEvent(code));
  }

  bool _isValidQrCode(String code) {
    final uuidRegex = RegExp(
        r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');
    return uuidRegex.hasMatch(code) || code.length >= 10;
  }

  void _resetScanning() {
    print('🔄 Resetting scanner...');
    setState(() {
      isProcessing = false;
    });
    cameraController.start();
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    print('🧹 Disposing QR scanner...');
    cameraController.dispose();
    super.dispose();
  }
}

// Custom overlay shape for the scanner
class QrScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;
  final double borderRadius;
  final double borderLength;
  final double cutOutSize;

  const QrScannerOverlayShape({
    this.borderColor = Colors.red,
    this.borderWidth = 3.0,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 80),
    this.borderRadius = 0,
    this.borderLength = 40,
    this.cutOutSize = 250,
  });

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path();
    path.addRect(rect);
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: rect.center,
        width: cutOutSize,
        height: cutOutSize,
      ),
      Radius.circular(borderRadius),
    ));
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(getOuterPath(rect), paint);

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final borderRect = Rect.fromCenter(
      center: rect.center,
      width: cutOutSize,
      height: cutOutSize,
    );

    final rrect = RRect.fromRectAndRadius(
      borderRect,
      Radius.circular(borderRadius),
    );

    // Draw corner brackets
    final bracketLength = borderLength;
    final bracketRadius = borderRadius;

    // Top left
    canvas.drawPath(
      Path()
        ..moveTo(rrect.left, rrect.top + bracketRadius + bracketLength)
        ..lineTo(rrect.left, rrect.top + bracketRadius)
        ..arcToPoint(Offset(rrect.left + bracketRadius, rrect.top),
            radius: Radius.circular(bracketRadius))
        ..lineTo(rrect.left + bracketRadius + bracketLength, rrect.top),
      borderPaint,
    );

    // Top right
    canvas.drawPath(
      Path()
        ..moveTo(rrect.right - bracketRadius - bracketLength, rrect.top)
        ..lineTo(rrect.right - bracketRadius, rrect.top)
        ..arcToPoint(Offset(rrect.right, rrect.top + bracketRadius),
            radius: Radius.circular(bracketRadius))
        ..lineTo(rrect.right, rrect.top + bracketRadius + bracketLength),
      borderPaint,
    );

    // Bottom left
    canvas.drawPath(
      Path()
        ..moveTo(rrect.left, rrect.bottom - bracketRadius - bracketLength)
        ..lineTo(rrect.left, rrect.bottom - bracketRadius)
        ..arcToPoint(Offset(rrect.left + bracketRadius, rrect.bottom),
            radius: Radius.circular(bracketRadius))
        ..lineTo(rrect.left + bracketRadius + bracketLength, rrect.bottom),
      borderPaint,
    );

    // Bottom right
    canvas.drawPath(
      Path()
        ..moveTo(rrect.right - bracketRadius - bracketLength, rrect.bottom)
        ..lineTo(rrect.right - bracketRadius, rrect.bottom)
        ..arcToPoint(Offset(rrect.right, rrect.bottom - bracketRadius),
            radius: Radius.circular(bracketRadius))
        ..lineTo(rrect.right, rrect.bottom - bracketRadius - bracketLength),
      borderPaint,
    );
  }

  @override
  ShapeBorder scale(double t) {
    return QrScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}
