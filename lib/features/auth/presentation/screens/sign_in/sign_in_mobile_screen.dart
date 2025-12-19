// ignore_for_file: deprecated_member_use

import 'package:coubot/core/utils/app_colors.dart';
import 'package:coubot/core/utils/assets.dart';
import 'package:flutter/material.dart';

class SignInMobileScreen extends StatelessWidget {
  const SignInMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Red container with rounded bottom corners
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 17,
                    offset: const Offset(0, 3),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    // Logo
                    Image.asset(Assets.genCoubotLogo, height: 80),
                    const SizedBox(height: 50),
                    // Email field
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF2F3),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Password field
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF2F3),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
                          border: InputBorder.none,
                          
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Login button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // OR text
            const Text(
              'OR',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            // Sign up text
            TextButton(
              onPressed: () {},
              child: const Text(
                'Sign up if you\'re new',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
