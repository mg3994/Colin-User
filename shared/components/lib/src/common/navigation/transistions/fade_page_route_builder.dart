// import 'package:animations/animations.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';


class FadePageRouteBuilder extends PageRouteBuilder {
  FadePageRouteBuilder({
    super.settings,
    required super.pageBuilder,
    super.opaque = false,
    super.transitionDuration = const Duration(milliseconds: 350),
  }) : super(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
                      opacity: animation,
                      child: child,
                    ));
}

// typedef Widget PageBuilder();

// class PageRoutes {
//   static const double kDefaultDuration = .35;
//   static const Curve kDefaultEaseFwd = Curves.easeOut;
//   static const Curve kDefaultEaseReverse = Curves.easeOut;

//   static Route<T> fade<T>(PageBuilder pageBuilder,
//       [double duration = kDefaultDuration]) {
//     return PageRouteBuilder<T>(
//       transitionDuration: Duration(milliseconds: (duration * 1000).round()),
//       pageBuilder: (context, animation, secondaryAnimation) => pageBuilder(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return FadeTransition(opacity: animation, child: child);
//       },
//     );
//   }

//   static Route<T> fadeThrough<T>(PageBuilder pageBuilder,
//       [double duration = kDefaultDuration]) {
//     return PageRouteBuilder<T>(
//       transitionDuration: Duration(milliseconds: (duration * 1000).round()),
//       pageBuilder: (context, animation, secondaryAnimation) => pageBuilder(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return FadeThroughTransition(
//             animation: animation,
//             secondaryAnimation: secondaryAnimation,
//             child: child);
//       },
//     );
//   }

//   static Route<T> fadeScale<T>(PageBuilder pageBuilder,
//       [double duration = kDefaultDuration]) {
//     return PageRouteBuilder<T>(
//       transitionDuration: Duration(milliseconds: (duration * 1000).round()),
//       pageBuilder: (context, animation, secondaryAnimation) => pageBuilder(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return FadeScaleTransition(animation: animation, child: child);
//       },
//     );
//   }

//   static Route<T> sharedAxis<T>(PageBuilder pageBuilder,
//       [SharedAxisTransitionType type = SharedAxisTransitionType.scaled,
//       double duration = kDefaultDuration]) {
//     return PageRouteBuilder<T>(
//       transitionDuration: Duration(milliseconds: (duration * 1000).round()),
//       pageBuilder: (context, animation, secondaryAnimation) => pageBuilder(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return SharedAxisTransition(
//           child: child,
//           animation: animation,
//           secondaryAnimation: secondaryAnimation,
//           transitionType: type,
//         );
//       },
//     );
//   }

  // static Route<T> slide<T>(PageBuilder pageBuilder,
  //     {double duration = kDefaultDuration,
  //     Offset startOffset = const Offset(1, 0),
  //     Curve easeFwd = kDefaultEaseFwd,
  //     Curve easeReverse = kDefaultEaseReverse}) {
  //   return PageRouteBuilder<T>(
  //     transitionDuration: Duration(milliseconds: (duration * 1000).round()),
  //     pageBuilder: (context, animation, secondaryAnimation) => pageBuilder(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       bool reverse = animation.status == AnimationStatus.reverse;
  //       return SlideTransition(
  //         position: Tween<Offset>(begin: startOffset, end: Offset(0, 0))
  //             .animate(CurvedAnimation(
  //                 parent: animation, curve: reverse ? easeReverse : easeFwd)),
  //         child: child,
  //       );
  //     },
  //   );
  // }
// }
