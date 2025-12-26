import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'widgets/auth_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 🔑 keyboard fix
      backgroundColor: const Color(0xFFFFF1F1),
      body: Stack(
        children: [
          /// RED TOP SECTION (FULL TO TOP)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
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
                /// LOGO (horizontal, smaller)
                Image.asset(
                  'assets/gen/images/logo_horizontal.png',
                  height: 60,
                ),
                const SizedBox(height: 28),

                AuthInputField(hint: 'Email'),
                const SizedBox(height: 16),
                AuthInputField(hint: 'Password', obscure: true),

                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontFamily: 'MadeEvolveSans',
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                ),
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
                  AuthMainButton(text: 'Login'),
                  const SizedBox(height: 16),
                  const Text('OR'),
                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign up if you’re new',
                      style: TextStyle(
                        fontFamily: 'MadeEvolveSans',
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}