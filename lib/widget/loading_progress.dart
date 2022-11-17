import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingProgress extends StatelessWidget {
  const LoadingProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lotties/loading.json',
        width: 150,
        height: 150,
      ),
    );
  }
}
