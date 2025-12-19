import 'package:coubot/features/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Change Password Mobile Screen Body
class ChangePasswordMobileScreenBody extends StatefulWidget {
  /// Change Password Mobile Screen Body constructor
  const ChangePasswordMobileScreenBody({super.key});

  @override
  State<ChangePasswordMobileScreenBody> createState() =>
      _ChangePasswordMobileScreenBodyState();
}

class _ChangePasswordMobileScreenBodyState
    extends State<ChangePasswordMobileScreenBody> {
  @override
  void initState() {
    super.initState();
    context.read<ForgetPasswordCubit>().initChangePassMethod(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
