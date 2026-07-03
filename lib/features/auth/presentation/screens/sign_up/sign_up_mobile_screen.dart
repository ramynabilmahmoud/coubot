import 'package:auto_route/auto_route.dart';
import 'package:coubot/config/themes/app_colors.dart';
import 'package:coubot/features/auth/presentation/cubits/auth_actions_cubit/auth_actions_cubit.dart';
import 'package:coubot/features/auth/presentation/cubits/login_register_cubit/login_register_cubit.dart';
import 'package:coubot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:coubot/features/auth/presentation/widgets/auth_main_button.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpMobileScreen extends StatefulWidget {
  const SignUpMobileScreen({super.key});

  @override
  State<SignUpMobileScreen> createState() => _SignUpMobileScreenState();
}

class _SignUpMobileScreenState extends State<SignUpMobileScreen>
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
    // Add this line just before the SvgPicture widget, inside the build method:
    final logoPath = Theme.of(context).brightness == Brightness.dark
        ? 'assets/gen/SVGs/Logo white_2.svg'
        : 'assets/gen/SVGs/Logo Black.svg';
    final cs = Theme.of(context).colorScheme;
    final loginCubit = context.read<LoginAndRegisterCubit>();
    final actionsCubit = context.read<AuthActionsCubit>();

    return BlocListener<LoginAndRegisterCubit, LoginAndRegisterState>(
      listener: (context, state) {
        if (state is RegisterError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
        if (state is RegisterSuccess) {
          context.router.replaceNamed('/app-layout-wrapper');
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
                  // ── Back button ───────────────────────────────────────────
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                        color: cs.onSurface,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Brand block ───────────────────────────────────────────
                  SvgPicture.asset(
                    logoPath,
                    height: 80,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ── Headline ──────────────────────────────────────────────
                  Text(
                    S.of(context).signUp,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: cs.onSurface,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    S.of(context).loginInIfYouHaveAnAccount,
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onSurface.withValues(alpha: 0.55),
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
                        Row(
                          children: [
                            Expanded(
                              child: AuthInputField(
                                hint: S.of(context).firstName,
                                iconData: Icons.person_outline,
                                controller: loginCubit.firstNameController,
                                onChanged: actionsCubit.checkNameFilled,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: AuthInputField(
                                hint: S.of(context).lastName,
                                controller: loginCubit.secondNameController,
                                onChanged: actionsCubit.checkNameFilled,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ── Primary button ────────────────────────────────────────
                  BlocBuilder<AuthActionsCubit, AuthActionsState>(
                    builder: (context, aState) {
                      return BlocBuilder<
                        LoginAndRegisterCubit,
                        LoginAndRegisterState
                      >(
                        builder: (context, lState) {
                          final isLoading = lState is RegisterLoading;
                          final canSubmit =
                              aState.isEmailFilled &&
                              aState.isUserNameFilled &&
                              aState.isSetPasswordFilled &&
                              !isLoading;
                          return AuthMainButton(
                            text: isLoading
                                ? S.of(context).justWaitASecond
                                : S.of(context).signUp,
                            onPressed: canSubmit ? loginCubit.signUp : null,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // ── Login link ────────────────────────────────────────────
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
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          S.of(context).login,
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
