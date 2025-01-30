import 'package:flutter/material.dart';

class InternalGrid extends StatelessWidget {
  final double boxSize;

  const InternalGrid({super.key, required this.boxSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxSize,
      width: boxSize,
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(9, (x) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.3),
            ),
          );
        }),
      ),
    );
  }
}
