import 'package:flutter/material.dart';
// Used With Mouse as it scroll as we scroll it goes smooth
class SmoothScrollController extends ScrollController {
  SmoothScrollController({
    super.initialScrollOffset,
    super.keepScrollOffset,
    super.debugLabel,
    this.velocityMultiplier = 5,
  });

  final double velocityMultiplier;

  @override
  ScrollPosition createScrollPosition(
      ScrollPhysics physics, ScrollContext context, ScrollPosition? oldPosition) {
    return SmoothScrollPositionWithSingleContext(
      velocityMultiplier: velocityMultiplier,
      physics: physics,
      context: context,
      initialPixels: initialScrollOffset,
      keepScrollOffset: keepScrollOffset,
      oldPosition: oldPosition,
      debugLabel: debugLabel,
    );
  }
}

class SmoothScrollPositionWithSingleContext extends ScrollPositionWithSingleContext {
  SmoothScrollPositionWithSingleContext({
    required this.velocityMultiplier,
    required super.physics,
    required super.context,
    super.initialPixels,
    super.keepScrollOffset,
    super.oldPosition,
    super.debugLabel,
  });

  final double velocityMultiplier;

  @override
  void pointerScroll(double delta) {
    double velocity = ((activity?.velocity ?? 0.0) + (delta * velocityMultiplier))
        .clamp(-physics.maxFlingVelocity, physics.maxFlingVelocity);
    goBallistic(velocity);
  }
}