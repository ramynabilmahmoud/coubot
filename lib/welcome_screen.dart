import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC72C41),
      body: SafeArea(
        child: Stack(
          children: [
            /// LEFT FOOD ICONS
            Positioned(
              left: 10,
              top: 40,
              child: Image.asset(
                'assets/gen/images/food_icons.png',
                height: 180,
              ),
            ),

            /// RIGHT LOGO (MOVED UP)
            Positioned(
              right: 5,
              top: 40, // 👈 key change
              child: Image.asset(
                'assets/gen/images/logo_vertical.png',
                height: MediaQuery.of(context).size.height * 0.55,
              ),
            ),

            /// CENTER CONTENT
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Your favorite food\nDelivered to you',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'MadeEvolveSansEvo',
                        fontSize: 26,
                        height: 1.3,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// GOOGLE
                    _AuthButton(
                      text: 'Connect with Google',
                      textColor: const Color(0xFFC72C41),
                      background: Colors.white,
                    ),

                    const SizedBox(height: 16),

                    /// FACEBOOK
                    _AuthButton(
                      text: 'Connect with Facebook',
                      textColor: Colors.white,
                      background: const Color(0xFF1877F2),
                    ),

                    const SizedBox(height: 20),

                    /// EMAIL (NO UNDERLINE)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Continue with E-mail',
                        style: TextStyle(
                          fontFamily: 'MadeEvolveSans',
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// REUSABLE BUTTON
class _AuthButton extends StatelessWidget {
  final String text;
  final Color background;
  final Color textColor;

  const _AuthButton({
    required this.text,
    required this.background,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'MadeEvolveSans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}