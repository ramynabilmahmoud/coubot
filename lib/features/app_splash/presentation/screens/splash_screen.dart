import 'package:auto_route/auto_route.dart';
import 'package:coubot/core/extensions/num_extensions.dart';
import 'package:coubot/core/utils/sized_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// SplashScreen
@RoutePage()
class SplashScreen extends StatelessWidget {
  /// SplashScreen
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: AppColors.outrageousOrange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              //Assets.genIconsSplashLogo,
              'assets/gen/icons/splash_logo.svg',
              height: 8.5.h,
              width: 8.5.w,
            ),
            SizedX.h17p5,
            SizedX.h13,
            SizedX.h2,
            // Lottie.asset(
            //   Assets.genLottieLoading,
            //   height: 18.h,
            //   renderCache: RenderCache.raster,
            // ),
          ],
        ),
      ),
    );
  }
}
