import 'dart:async';
import 'package:flutter/material.dart';

/// Supports manual control over auto-hide behavior
class ControllableAutoHideWidget extends StatefulWidget {
  final Widget child;
  final bool initiallyVisible;
  final Duration delay;
  final Duration fadeDuration;
  final Curve fadeCurve;
  final bool autoHide;

  const ControllableAutoHideWidget({
    super.key,
    required this.child,
    this.initiallyVisible = true,
    required this.delay,
    this.fadeDuration = const Duration(milliseconds: 300),
    this.fadeCurve = Curves.easeInOut,
    this.autoHide = true,
  });

  @override
  State<ControllableAutoHideWidget> createState() =>
      ControllableAutoHideWidgetState();
}

class ControllableAutoHideWidgetState
    extends State<ControllableAutoHideWidget> {
  late bool _isVisible;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _isVisible = widget.initiallyVisible;
    if (_isVisible && widget.autoHide) {
      _startHideTimer();
    }
  }

  /// Starts the timer to auto-hide the widget
  void _startHideTimer() {
    _hideTimer?.cancel();
    if (widget.autoHide) {
      _hideTimer = Timer(widget.delay, () {
        if (mounted) {
          setState(() {
            _isVisible = false;
          });
        }
      });
    }
  }

  /// 🎯 Handles showing the widget
  void show() {
    if (!mounted) return;

    setState(() {
      _isVisible = true;
    });

    // 显示后重新开始定时隐藏（如果启用自动隐藏）
    if (widget.autoHide) {
      _startHideTimer();
    }
  }

  /// 🎯 Handles hiding the widget
  void hide() {
    if (!mounted) return;

    setState(() {
      _isVisible = false;
    });
    _hideTimer?.cancel();
  }

  /// 🎯 Switches visibility state
  void toggle() {
    if (_isVisible) {
      hide();
    } else {
      show();
    }
  }

  /// 🎯 Resets the hide timer and shows the widget
  void resetAndShow() {
    hide();
    Future.delayed(const Duration(milliseconds: 50), () {
      show();
    });
  }

  @override
  void didUpdateWidget(ControllableAutoHideWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If delay changed, restart the hide timer
    if (oldWidget.delay != widget.delay && _isVisible && widget.autoHide) {
      _startHideTimer();
    }
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: widget.fadeDuration,
      curve: widget.fadeCurve,
      child: widget.child,
    );
  }
}
