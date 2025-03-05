import 'package:flutter/material.dart';

class RadialAnimation extends TweenAnimationBuilder {
  final AlignmentGeometry center;

  RadialAnimation({
    required this.center,
    super.key,
    required super.tween,
    super.duration = const Duration(milliseconds: 1500),
  }) : super(
          builder: (BuildContext context, Object? value, Widget? child) =>
              ShaderMask(
                  shaderCallback: (rect) {
                    return RadialGradient(
                            radius: 5 * (value as double),
                            colors: [
                              Colors.white,
                              Colors.white,
                              Colors.transparent, //Transparet
                              Colors.transparent, //Transparent
                            ],
                            stops: const [0.0, 0.55, 0.6, 1.0],
                            center: center)
                        .createShader(rect);
                  },
                  child: child),
        );
}
