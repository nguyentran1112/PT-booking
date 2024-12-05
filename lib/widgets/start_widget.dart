import 'package:flutter/material.dart';

class StartWidget extends StatelessWidget {
  const StartWidget({super.key, this.value});
  final double? value;
  @override
  Widget build(BuildContext context) {

    // build rating star 
    return Row(
      children: List.generate(5, (index) {
        if (index >= value!) {
          return const Icon(Icons.star_border, color: Colors.amber);
        }
        return const Icon(Icons.star, color: Colors.amber);
      }),
    );
  
  }
}