import 'package:auto_route/auto_route.dart';
import 'package:coubot/config/routes/app_router.gr.dart';
import 'package:coubot/config/themes/app_colors.dart';
import 'package:coubot/features/auth/presentation/cubits/auth_actions_cubit/auth_actions_cubit.dart';
import 'package:coubot/features/auth/presentation/cubits/login_register_cubit/login_register_cubit.dart';
import 'package:coubot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:coubot/features/auth/presentation/widgets/auth_main_button.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInMobileScreen extends StatefulWidget {
  const SignInMobileScreen({super.key});

  @override
  State<SignInMobileScreen> createState() => _SignInMobileScreenState();
}

class _SignInMobileScreenState extends State<SignInMobileScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..forward();
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final loginCubit = context.read<LoginAndRegisterCubit>();
    final actionsCubit = context.read<AuthActionsCubit>();

    return BlocListener<LoginAndRegisterCubit, LoginAndRegisterState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
        if (state is LoginSuccess) {
          context.router.replace(const AppLayoutWrapper());
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Brand block ──────────────────────────────────────────
                  Center(
                    child: Image.asset(
                      'assets/gen/images/logo_vertical.png',
                      height: 90,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ── Headline ─────────────────────────────────────────────
                  Text(
                    S.of(context).login,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: cs.onSurface,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ── Form card ─────────────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AuthInputField(
                          hint: S.of(context).email,
                          iconData: Icons.email_outlined,
                          controller: loginCubit.emailController,
                          onChanged: (v) =>
                              actionsCubit.checkEmailFilled(v.trim()),
                        ),
                        const SizedBox(height: 16),
                        AuthInputField(
                          hint: S.of(context).password,
                          iconData: Icons.lock_outline,
                          obscure: true,
                          controller: loginCubit.setPasswordController,
                          onChanged: actionsCubit.checkSetPasswordFilled,
                        ),
                        const SizedBox(height: 10),

                        // Forgot password
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            S.of(context).forgotPassword,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ── Primary button ────────────────────────────────────────
                  BlocBuilder<AuthActionsCubit, AuthActionsState>(
                    builder: (context, aState) {
                      return BlocBuilder<LoginAndRegisterCubit,
                          LoginAndRegisterState>(
                        builder: (context, lState) {
                          final isLoading = lState is LoginLoading;
                          final canSubmit = aState.isEmailFilled &&
                              aState.isSetPasswordFilled &&
                              !isLoading;
                          return AuthMainButton(
                            text: S.of(context).login,
                            isLoading: isLoading,
                            onPressed: canSubmit
                                ? loginCubit.signInWithEmailAndPassword
                                : null,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // ── Sign up link ──────────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).or,
                        style: TextStyle(
                          fontSize: 13,
                          color: cs.onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => context.router.push(const SignUpRoute()),
                        child: Text(
                          S.of(context).signUpIfYoureNew,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
