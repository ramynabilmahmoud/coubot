import 'package:flutter/material.dart';

/// An [AdaptiveLayout] widget provides a way to create responsive layouts
/// in Flutter applications.
/// It adapts the UI based on the screen size, allowing
/// for a tailored user experience across
/// different devices such as mobile, tablet, and web platforms.
///
/// This widget uses a [LayoutBuilder] to determine the available
/// width and switches between
/// different layouts accordingly. It is designed to simplify the creation
/// of responsive UIs
/// by encapsulating the layout decision logic.
///
/// Parameters:
/// - [mobileLayout]: A [WidgetBuilder] function that returns the layout
///   for mobile devices.
///   This layout is used when the screen width is less than 600 pixels.
///
/// - [tabletLayout]: A [WidgetBuilder] function that returns the layout
///   for tablet devices.
///   This layout is used when the screen width is between 600 and 1200 pixels.
///
/// - [webLayout]: A [WidgetBuilder] function that returns the layout
///   for web and larger screens.
///   This layout is used when the screen width is greater than 1200 pixels.
///
/// Usage:
/// ```
/// AdaptiveLayout(
///   mobileLayout: (context) => MobileLayout(),
///   tabletLayout: (context) => TabletLayout(),
///   webLayout: (context) => WebLayout(),
/// )
/// ```
///
/// This approach ensures that the correct layout is
/// used for the device's screen size, and it
/// defers the creation of the widget until it is actually needed,
///  based on the platform's screen size.
class AdaptiveLayout extends StatelessWidget {
  /// Constructor for [AdaptiveLayout].
  ///
  /// Requires a [mobileLayout], [tabletLayout], and [webLayout] to provide the
  /// specific layouts
  /// for different screen sizes.
  const AdaptiveLayout({
    required this.mobileLayout,
    required this.tabletLayout,
    required this.webLayout,
    super.key,
  });

  /// Widget for mobile layout.
  /// This layout is chosen when the screen width is less than 600 pixels.
  final WidgetBuilder mobileLayout;

  /// Widget for tablet layout.
  /// This layout is chosen when the screen width is between 600 and 1200 pixels
  final WidgetBuilder tabletLayout;

  /// Widget for web layout.
  /// This layout is chosen when the screen width is greater than 1200 pixels.
  final WidgetBuilder webLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobileLayout(context);
        } else if (constraints.maxWidth < 1200) {
          return tabletLayout(context);
        } else {
          return webLayout(context);
        }
      },
    );
  }
}
