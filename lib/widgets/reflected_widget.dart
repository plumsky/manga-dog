import 'package:flutter/material.dart';

/// Simple widget that displays a reflection of its child below it.
class ReflectedWidget extends StatelessWidget {
  final Widget child;
  final double reflectionRatio;
  final double shadowHeight;
  final double opacity;
  final double scale;

  const ReflectedWidget({
    super.key,
    required this.child,
    this.reflectionRatio = 0.3,
    this.shadowHeight = 20.0,
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
        ShaderMask(
          blendMode: BlendMode.dstOver,
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withAlpha(128), Colors.transparent],
            ).createShader(bounds);
          },
          child: Transform(
            alignment: Alignment.bottomCenter,
            transform: Matrix4.identity()..scaleByDouble(1.0, -1.0, 1.0, 1.0), // 垂直翻转
            child: Opacity(
              opacity: 0.7,
              child: child, // 替换为你的实际组件
            ),
          ),
        )
      ],
    );
  }
}
