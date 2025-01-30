import 'package:flutter/material.dart';

class InternalGrid extends StatelessWidget {
  final double boxSize;
  final List<int> values; // Values for the 3x3 block
  final void Function(int, int) onCellTap; // Callback when a cell is tapped
  final bool isSelected; // To track if the current cell is selected

  const InternalGrid({
    super.key,
    required this.boxSize,
    required this.values,
    required this.onCellTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxSize,
      width: boxSize,
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(9, (x) {
          int value = values[x]; // Get the value for the cell
          return InkWell(
            onTap: () {
              int row = x ~/ 3; // Determine the row in the block
              int col = x % 3;  // Determine the column in the block
              onCellTap(row, col); // Trigger the cell tap callback
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.3),
                color: isSelected
                    ? Colors.blueAccent.shade100.withAlpha(100)
                    : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  value == 0 ? "" : value.toString(), // Empty cell if 0
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
