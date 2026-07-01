import 'package:auto_route/auto_route.dart';
import 'package:coubot/features/auth/presentation/cubits/auth_actions_cubit/auth_actions_cubit.dart';
import 'package:coubot/features/auth/presentation/cubits/login_register_cubit/login_register_cubit.dart';
import 'package:coubot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:coubot/features/auth/presentation/widgets/auth_main_button.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SignUpMobileScreen extends StatelessWidget {
  const SignUpMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          // ✅ Remove OTP - user is registered directly to the users table
          context.router.replaceNamed('/app-layout-wrapper');
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF0F0F0),
        body: Stack(
          children: [
            /// RED TOP SECTION
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
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 90),

                  SvgPicture.asset(
                    'assets/gen/SVGs/Logo white_2.svg',
                    color: Colors.white,
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(height: 28),

                  /// FIRST NAME AND LAST NAME IN ROW
                  Row(
                    children: [
                      /// FIRST NAME
                      Expanded(
                        child: AuthInputField(
                          hint: S.of(context).firstName,
                          controller: loginCubit.firstNameController,
                          textColor: Colors.black,

                          onChanged: actionsCubit.checkNameFilled,
                        ),
                      ),
                      const SizedBox(width: 12),

                      /// LAST NAME
                      Expanded(
                        child: AuthInputField(
                          hint: S.of(context).lastName,
                          controller: loginCubit.secondNameController,
                          textColor: Colors.black,

                          onChanged: actionsCubit.checkNameFilled,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  /// EMAIL
                  AuthInputField(
                    hint: S.of(context).email,
                    controller: loginCubit.emailController,
                    textColor: Colors.black,

                    onChanged: (v) => actionsCubit.checkEmailFilled(v.trim()),
                  ),
                  const SizedBox(height: 16),

                  /// PASSWORD
                  AuthInputField(
                    hint: S.of(context).password,
                    obscure: true,
                    textColor: Colors.black,

                    controller: loginCubit.setPasswordController,
                    onChanged: actionsCubit.checkSetPasswordFilled,
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
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// SIGN UP BUTTON (enabled + loading)
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
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                              width: 250,
                              height: 70,
                              onPressed: canSubmit ? loginCubit.signUp : null,
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 16),
                    Text(S.of(context).or),
                    const SizedBox(height: 10),

                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        S.of(context).loginInIfYouHaveAnAccount,
                        style: const TextStyle(
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
      ),
    );
  }
}
