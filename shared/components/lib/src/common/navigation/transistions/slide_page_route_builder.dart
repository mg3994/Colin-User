import 'package:flutter/material.dart';

class SlidePageRouteBuilder extends PageRouteBuilder {
  final Offset startOffset;
  final Offset endOffset;
  final Curve forwardCurve;
  final Curve reverseCurve;
  SlidePageRouteBuilder({
    this.forwardCurve = Curves.easeOut,
    this.reverseCurve = Curves.easeOut,
    this.startOffset = const Offset(1, 0),
    this.endOffset = const Offset(0, 0),
    super.settings,
    required super.pageBuilder,
    super.opaque = false,
    super.transitionDuration = const Duration(milliseconds: 350),
  }) : super(transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          bool reverse = animation.status == AnimationStatus.reverse;
          return SlideTransition(
            position: Tween<Offset>(begin: startOffset, end: endOffset).animate(
                CurvedAnimation(
                    parent: animation,
                    curve: reverse ? reverseCurve : forwardCurve)),
            child: child,
          );
        });
}
