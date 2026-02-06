import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final double width;
  final double height;

  const LoadingWidget({super.key, this.message, this.width = 100, this.height = 100});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animations/dog_wait.json'),
            SizedBox(height: 16),
            (message != null && message!.isNotEmpty)
                ? Text(message!)
                : Container(),
          ],
        ),
      ),
    );
  }
}
