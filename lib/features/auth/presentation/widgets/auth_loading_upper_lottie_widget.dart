import 'package:coubot/core/extensions/num_extensions.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';

/// AuthLoadingUpperLottieWidget is used to manage
/// the auth loading upper lottie widget
class AuthLoadingUpperLottieWidget extends StatelessWidget {
  /// AuthLoadingUpperLottieWidget constructor
  const AuthLoadingUpperLottieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50.fh),
        Text(
          textAlign: TextAlign.center,
          S.of(context).justWaitASecond,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(),
        ),
      ],
    );
  }
}
