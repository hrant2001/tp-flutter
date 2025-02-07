import 'package:flutter/material.dart';

class InternalGrid extends StatelessWidget {
  final double boxSize;
  final List<int> values;
  final void Function(int, int) onCellTap;
  final int? selectedRow;
  final int? selectedCol;
  final int blockIndex; // Indice du bloc 3x3

  const InternalGrid({
    super.key,
    required this.boxSize,
    required this.values,
    required this.onCellTap,
    required this.selectedRow,
    required this.selectedCol,
    required this.blockIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxSize,
      width: boxSize,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (context, x) {
          int row = (blockIndex ~/ 3) * 3 + (x ~/ 3);
          int col = (blockIndex % 3) * 3 + (x % 3);
          bool isSelected = selectedRow == row && selectedCol == col;

          return InkWell(
            onTap: () => onCellTap(row, col),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.3),
                color: isSelected
                    ? Colors.blueAccent.shade100.withAlpha(100)
                    : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  values[x] == 0 ? "" : values[x].toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
