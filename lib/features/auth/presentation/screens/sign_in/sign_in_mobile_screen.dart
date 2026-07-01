// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:coubot/config/routes/app_router.gr.dart';
import 'package:coubot/features/auth/presentation/cubits/login_register_cubit/login_register_cubit.dart';
import 'package:coubot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:coubot/features/auth/presentation/widgets/auth_main_button.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SignInMobileScreen extends StatefulWidget {
  const SignInMobileScreen({super.key});

  @override
  State<SignInMobileScreen> createState() => _SignInMobileScreenState();
}

class _SignInMobileScreenState extends State<SignInMobileScreen> {
  String? _emailError;
  String? _passwordError;

  bool _isValidEmail(String email) {
    final trimmed = email.trim();
    return trimmed.isNotEmpty && trimmed.toLowerCase().endsWith('@gmail.com');
  }

  bool _isValidPassword(String password) {
    return password.length >= 8;
  }

  void _validateEmail(String value) {
    final trimmed = value.trim();
    setState(() {
      if (trimmed.isEmpty) {
        _emailError = null;
      } else if (!_isValidEmail(trimmed)) {
        _emailError = 'Email must end with @gmail.com';
      } else {
        _emailError = null;
      }
    });
  }

  void _validatePassword(String value) {
    setState(() {
      if (value.isEmpty) {
        _passwordError = null;
      } else if (!_isValidPassword(value)) {
        _passwordError = 'Password must be at least 8 characters';
      } else {
        _passwordError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginAndRegisterCubit>();

    return BlocListener<LoginAndRegisterCubit, LoginAndRegisterState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }

        if (state is LoginSuccess) {
          context.router.replace(const AppLayoutWrapper());
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF0F0F0),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 480,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              decoration: const BoxDecoration(
                color: Color(0xFFBD2D3D),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(55),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 60),
                  SvgPicture.asset(
                    'assets/gen/SVGs/Logo white_2.svg',
                    color: Colors.white,
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(height: 80),
                  AuthInputField(
                    hint: S.of(context).email,
                    controller: loginCubit.emailController,
                    textColor: Colors.black,
                    onChanged: _validateEmail,
                  ),
                  if (_emailError != null) ...[
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _emailError!,
                        style: TextStyle(
                          fontFamily: 'MadeEvolveSans',
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.95),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  AuthInputField(
                    hint: S.of(context).password,
                    obscure: true,
                    controller: loginCubit.setPasswordController,
                    textColor: Colors.black,
                    onChanged: _validatePassword,
                  ),
                  if (_passwordError != null) ...[
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _passwordError!,
                        style: TextStyle(
                          fontFamily: 'MadeEvolveSans',
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.95),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      S.of(context).forgotPassword,
                      style: TextStyle(
                        fontFamily: 'MadeEvolveSans',
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<LoginAndRegisterCubit, LoginAndRegisterState>(
                      builder: (context, lState) {
                        final isLoading = lState is LoginLoading;
                        final email = loginCubit.emailController.text.trim();
                        final password = loginCubit.setPasswordController.text;
                        final canSubmit =
                            _isValidEmail(email) &&
                            _isValidPassword(password) &&
                            !isLoading;

                        return AuthMainButton(
                          text: S.of(context).login,
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                          width: 250,
                          height: 70,
                          isLoading: isLoading,
                          onPressed: canSubmit
                              ? loginCubit.signInWithEmailAndPassword
                              : null,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(S.of(context).or),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => context.router.push(const SignUpRoute()),
                      child: Text(
                        S.of(context).signUpIfYoureNew,
                        style: const TextStyle(
                          fontFamily: 'MadeEvolveSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                          color: Colors.black,
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
