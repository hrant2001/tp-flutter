import 'package:flutter/material.dart';

class InternalGrid extends StatelessWidget {
  final double boxSize;
  final List<int> values; // Values for the 3x3 block

  const InternalGrid({super.key, required this.boxSize, required this.values});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxSize,
      width: boxSize,
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(9, (x) {
          int value = values[x]; // Get the value for the cell
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.3),
            ),
            child: Center(
              child: Text(
                value == 0 ? "" : value.toString(), // Empty cell if 0
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }),
      ),
    );
  }
}
