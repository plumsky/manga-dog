import 'package:flutter/material.dart';

/// Simple widget that displays a reflection of its child below it.
class ReflectedWidget extends StatelessWidget {
  final Widget child;
  final double reflectionHeight;
  final double opacity;
  final double scale;

  const ReflectedWidget({
    super.key,
    required this.child,
    this.reflectionHeight = 100,
    this.opacity = 0.3,
    this.scale = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Original
        child,

        /// Shadow gap between original and reflection
        Transform(
          alignment: Alignment.topCenter,
          transform: Matrix4.identity()
            ..scaleByDouble(1.0, -scale, 1.0, 1.0)
            ..translateByDouble(0.0, -reflectionHeight * (1 - scale), 0.0, 1.0),
          child: ClipRect(
            child: SizedBox(
              height: reflectionHeight,
              child: Opacity(
                opacity: opacity,
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
