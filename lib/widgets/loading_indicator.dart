// lib/widgets/loading_indicator.dart

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        

          const SizedBox(height: 16),

          // Tu animación Lottie
          SizedBox(
            width: 100,
            height: 100,
            child: Lottie.asset('assets/icons/loading.json',
              repeat: true,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
