import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets/auth_widgets.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  int _secondsLeft = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsLeft = 30;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsLeft--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFF1F1),
      body: Stack(
        children: [
          /// RED TOP SECTION
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
            decoration: const BoxDecoration(
              color: Color(0xFFC72C41),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(55),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/gen/images/logo_horizontal.png',
                  height: 60,
                ),
                const SizedBox(height: 28),

                const Text(
                  'We have sent a code\nto your email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'MadeEvolveSansEvo',
                    fontSize: 18,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 24),

                AuthInputField(hint: 'Code'),
              ],
            ),
          ),

          /// BACK ARROW
          SafeArea(
            child: IconButton(
              icon: Image.asset(
                'assets/gen/images/chevron_backward.png',
                height: 22,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          /// BOTTOM SECTION
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// RESEND BUTTON + TIMER
                  TextButton(
                    onPressed: _secondsLeft == 0
                        ? () {
                      _startTimer();
                    }
                        : null,
                    child: Text(
                      _secondsLeft == 0
                          ? 'Resend code'
                          : 'Resend in ${_secondsLeft}s',
                      style: TextStyle(
                        fontFamily: 'MadeEvolveSans',
                        fontSize: 14,
                        color: _secondsLeft == 0
                            ? const Color(0xFFC72C41)
                            : Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// VERIFY BUTTON
                  AuthMainButton(text: 'Verify'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}