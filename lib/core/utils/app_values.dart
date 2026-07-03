import 'package:flutter/widgets.dart';
import 'package:coubot/core/extensions/num_extensions.dart';

/// this class is the app static values
class AppValues {
  /// the app bar height
  static double appBarHeight = 6.h;

  /// the app is in test mode or not
  static bool isTest = false;

  /// Aspect ratio for the Our Destinations list
  static double ourDestinationsListRatio = 19 / 5.8;

  /// Aspect ratio for the Ready Packages list
  static double readyPackagesListRatio = 16 / 10;

  /// active requests under container list of box shadow
  static List<BoxShadow> underContainerListBoxShadow = const [
    BoxShadow(color: Color(0x08C2C2C2), offset: Offset(1, 3), blurRadius: 8),
    BoxShadow(color: Color(0x08C2C2C2), offset: Offset(5, 13), blurRadius: 14),
    BoxShadow(color: Color(0x05C2C2C2), offset: Offset(11, 30), blurRadius: 19),
    BoxShadow(
      color: Color(0x00C2C2C2), // This is fully transparent.
      offset: Offset(19, 53),
      blurRadius: 22,
    ),
    BoxShadow(
      color: Color(0x00C2C2C2), // This is also fully transparent.
      offset: Offset(30, 82),
      blurRadius: 24,
    ),
  ];

  /// active requests upper container list of box shadow
  static List<BoxShadow> upperContainerListBoxShadow = const [
    BoxShadow(color: Color(0x08C2C2C2), offset: Offset(1, 3), blurRadius: 8),
    BoxShadow(color: Color(0x08C2C2C2), offset: Offset(5, 13), blurRadius: 14),
    BoxShadow(color: Color(0x05C2C2C2), offset: Offset(11, 30), blurRadius: 19),
    BoxShadow(
      color: Color(0x00C2C2C2), // This effectively makes the shadow invisible.
      offset: Offset(19, 53),
      blurRadius: 22,
    ),
    BoxShadow(
      color: Color(0x00C2C2C2), // This effectively makes the shadow invisible.
      offset: Offset(30, 82),
      blurRadius: 24,
    ),
  ];

  /// home gap between widgets
  static double homeGap = 28.fh;

  /// home gap between latest delivered packages title and list
  static double latestDeliveredPackagesGap = 18.fh;

  /// home gap between ready packages list and latest delivered packages
  static double readyPackagesListAndLatestDeliveredPackagesGap = 30.fh;

  /// samsung j6 max width
  static double samsungJ6MaxWidth = 354.49703138252755;

  /// asterisk
  static String asterisk = '*';
}
