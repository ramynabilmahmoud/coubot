import 'package:flutter/material.dart';
import 'widgets/auth_widgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                /// LOGO
                Image.asset(
                  'assets/gen/images/logo_horizontal.png',
                  height: 60,
                ),
                const SizedBox(height: 28),

                AuthInputField(hint: 'User-name'),
                const SizedBox(height: 16),
                AuthInputField(hint: 'Email'),
                const SizedBox(height: 16),
                AuthInputField(hint: 'Password', obscure: true),
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
                  AuthMainButton(text: 'Sign Up'),
                  const SizedBox(height: 16),
                  const Text('OR'),
                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // 👈 back to login
                    },
                    child: const Text(
                      'Login in if you have an account',
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