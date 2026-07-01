import 'dart:async' show StreamController;

import 'package:coubot/core/utils/sized_x.dart';
import 'package:flutter/material.dart';

/// Loading
class AuthLoading {
  /// instance
  factory AuthLoading.instance() => _shared;
  AuthLoading._sharedInstance();
  static final AuthLoading _shared = AuthLoading._sharedInstance();

  /// controller
  AuthLoadingController? controller;

  /// show
  void show({
    required BuildContext context,
    String? text,
    Widget? upperLottieWidget,
    double? width,
    double? height,
  }) {
    if (controller?.update(text) ?? false) {
      return;
    } else {
      controller = showOverlay(
        context: context,
        text: text,
        upperLottieWidget: upperLottieWidget,
        width: width,
        height: height,
      );
    }
  }

  /// hide
  void hide() {
    controller?.close();
    controller = null;
  }

  /// showOverlay
  AuthLoadingController showOverlay({
    required BuildContext context,
    String? text,
    Widget? upperLottieWidget,
    double? width,
    double? height,
  }) {
    final text0 = StreamController<String>();
    if (text != null) {
      text0.add(text);
    }

    final state = Overlay.of(context);

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (upperLottieWidget != null) upperLottieWidget,
                // TODO: Change the color of the loading animation
                // Lottie.asset(
                //   Assets.genLottieLoading,
                //   width: width ?? 15.h,
                //   height: height ?? 15.h,
                // ),
                SizedX.h3,
                if (text != null)
                  StreamBuilder(
                    stream: text0.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );

    state.insert(overlay);

    return AuthLoadingController(
      close: () {
        text0.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        if (text != null) {
          text0.add(text);
        }
        return true;
      },
    );
  }
}

/// CloseAuthLoading
typedef CloseAuthLoading = bool Function();

/// UpdateAuthLoading
typedef UpdateAuthLoading = bool Function(String? text);

/// AuthLoading  controller
@immutable
class AuthLoadingController {
  /// AuthLoadingController
  const AuthLoadingController({required this.close, required this.update});

  /// CloseAuthLoading
  final CloseAuthLoading close;

  /// UpdateAuthLoading
  final UpdateAuthLoading update;
}
