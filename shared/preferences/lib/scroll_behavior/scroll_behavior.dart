import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

final class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();
  @override
  Set<PointerDeviceKind> get dragDevices => super.dragDevices
    ..add(
      PointerDeviceKind.mouse,
    );
  // {
  //       PointerDeviceKind.touch,
  //       PointerDeviceKind.mouse,
  //       PointerDeviceKind.trackpad,
  //       PointerDeviceKind.stylus,
  //       PointerDeviceKind.invertedStylus,
  //       PointerDeviceKind.unknown
  //     };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
