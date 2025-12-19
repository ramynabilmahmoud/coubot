import 'package:flutter/material.dart';
import 'package:coubot/core/extensions/num_extensions.dart';
import 'package:coubot/core/utils/app_colors.dart';
import 'package:coubot/main.dart';

///
class SnackX {
  /// a method to show [SnackX]
  static void showSnackBar({
    required String message,
    required BuildContext? context,
  }) {
    final currentContext = context ?? appRouter.navigatorKey.currentContext;
    assert(currentContext != null, 'context cannot be null');
    ScaffoldMessenger.of(currentContext!).hideCurrentSnackBar();
    ScaffoldMessenger.of(currentContext).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: SizedBox(
          height: 7.h,
          child: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(currentContext).textTheme.labelMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
