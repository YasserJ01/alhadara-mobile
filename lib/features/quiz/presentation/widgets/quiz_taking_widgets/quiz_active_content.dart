import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/services/screenshot_detector.dart';
import '../../../../../core/services/screenshot_preventor.dart';
import '../../../domain/entities/quiz_question_entity.dart';
import '../../bloc/quiz_submission/quiz_submission_bloc.dart';
import 'quiz_app_bar.dart';
import 'quiz_body.dart';
import 'quiz_dialogs.dart';
import 'dart:ui' as ui;


class QuizActiveContent extends StatefulWidget {
  final QuizQuestionEntity questions;
  final int attemptId;  // Add this



  const QuizActiveContent({super.key, required this.questions,required this.attemptId});

  @override
  State<QuizActiveContent> createState() => _QuizActiveContentState();
}

class _QuizActiveContentState extends State<QuizActiveContent>
    with WidgetsBindingObserver {
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isQuizActive = false;
  Map<int, int> _selectedAnswers = {};
  bool _hasWarned = false;
  bool _appInBackground = false;
  final _blurFilter = ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5);
  bool _screenshotPreventionActive = false;




  @override
  void initState() {
    super.initState();
    _initScreenshotPrevention();
    WidgetsBinding.instance.addObserver(this);
    _preventScreenshots();
    _startTimer(widget.questions.timeLimitMinutes);

    // Initialize screenshot detection
    if (Platform.isAndroid) {
      ScreenshotPreventer.preventScreenshots();
    }
  }
  Future<void> _initScreenshotPrevention() async {
    try {
      _screenshotPreventionActive = await ScreenshotPreventer.preventScreenshots();
    } catch (e) {
      debugPrint("Screenshot prevention error: $e");
    }
  }

  @override
  void dispose() {
    if (Platform.isAndroid) {
      ScreenshotPreventer.allowScreenshots();
    }
    if (_screenshotPreventionActive) {
      ScreenshotPreventer.allowScreenshots().catchError((e) {
        debugPrint("Error allowing screenshots: $e");
      });
    }
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (_isQuizActive) {
      switch (state) {
        case AppLifecycleState.paused:
        case AppLifecycleState.detached:
        // When app is backgrounded or closed
          if (mounted) {
            _endQuizWithFailure();
          }
          break;
        case AppLifecycleState.inactive:
        // When opening recent apps or notification panel
          setState(() => _appInBackground = true);
          break;
        case AppLifecycleState.resumed:
        // When returning to full app view
          setState(() => _appInBackground = false);
          break;
        case AppLifecycleState.hidden:
          break;
      }
    }
  }

  void _preventScreenshots() {
    // Prevent screenshots on Android
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Lock orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Disable system UI popup on edge swipes
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [],
    );
  }

  void _startTimer(int minutes) {
    setState(() {
      _remainingSeconds = minutes * 60;
      _isQuizActive = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _endQuizWithTimeout();
      }
    });
  }

  void _endQuizWithTimeout() {
    _timer?.cancel();
    setState(() => _isQuizActive = false);
    QuizDialogs.showTimeoutDialog(context);
  }

  void _endQuizWithFailure() {
    _timer?.cancel();
    setState(() {
      _isQuizActive = false;
      _appInBackground = false;
    });

    // Reset system UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    // Show failure dialog that stays until user confirms
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) => AlertDialog(
        title: const Text('Quiz Terminated'),
        content: const Text(
          'The quiz has been terminated due to security violation. You cannot take another attempt for this quiz. Your score will be 0.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pop(context); // Go back to QuizListPage
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  void _showSecurityWarning() {
    if (!_hasWarned) {
      setState(() => _hasWarned = true);
      QuizDialogs.showSecurityWarning(context, _endQuizWithFailure);
    }
  }

  void _showExitWarning(BuildContext context) {
    QuizDialogs.showExitWarning(context, _endQuizWithFailure);
  }

  void _submitQuiz(BuildContext context) {
    QuizDialogs.showSubmitConfirmation(
      context,
      _selectedAnswers.length,
      widget.questions.questions.length,
      _finalSubmit,
    );
  }
  void _finalSubmit() {
    _timer?.cancel();
    setState(() => _isQuizActive = false);

    final answers = _selectedAnswers.entries.map((e) {
      return {
        'question_order': e.key,
        'choice_orders': [e.value], // Single choice only
      };
    }).toList();

    context.read<QuizSubmissionBloc>().add(
      SubmitQuizAnswersEvent(
        attemptId: widget.attemptId, // Use the passed attemptId
        answers: answers,
      ),
    );
  }

  Widget _buildBlurWrapper(Widget child) {
    return Stack(
      children: [
        child,
        if (_appInBackground)
          BackdropFilter(
            filter: _blurFilter,
            child: Container(
              color: Colors.black.withOpacity(0.3),
              width: double.infinity,
              height: double.infinity,
              child: const Center(
                child: Text(
                  'Return to quiz to continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return ScreenshotDetector(
      onScreenshotDetected: _showScreenshotWarning,
      child: PopScope(
        canPop: !_isQuizActive,
        onPopInvoked: (didPop) {
          if (!didPop && _isQuizActive) {
            _showExitWarning(context);
          }
        },
        child: Scaffold(
          appBar: QuizAppBar(
            isQuizActive: _isQuizActive,
            remainingSeconds: _remainingSeconds,
          ),
          body: _buildBlurWrapper(
             QuizBody(
              questions: widget.questions,
              selectedAnswers: _selectedAnswers,
              isQuizActive: _isQuizActive,
              onAnswerSelected: (questionOrder, choiceOrder) {
                setState(() {
                  _selectedAnswers[questionOrder] = choiceOrder;
                });
              },
              onSubmitQuiz: _isQuizActive ? () => _submitQuiz(context) : null,
            ),
          ),
        ),
      ),
    );
  }
  void _showScreenshotWarning() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Screenshots are not allowed during the quiz!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.1,
          left: 20,
          right: 20,
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}