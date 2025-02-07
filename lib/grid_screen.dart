import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart'; 
import 'internal_grid.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  late Puzzle puzzle;
  List<List<int>> board = List.generate(9, (_) => List.filled(9, 0));
  int? selectedRow;
  int? selectedCol;

  @override
  void initState() {
    super.initState();
    _generatePuzzle();
  }

  Future<void> _generatePuzzle() async {
    puzzle = Puzzle(PuzzleOptions(patternName: "winter"));
    await puzzle.generate(); 

    setState(() {
      for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
          board[i][j] = puzzle.board()?.matrix()?[i][j].getValue() ?? 0;
        }
      }
      selectedRow = null;
      selectedCol = null;
    });
  }

  void _onCellTap(int row, int col) {
    setState(() {
      selectedRow = row;
      selectedCol = col;
    });
  }

  void _onNumberTap(int value) {
    if (selectedRow != null && selectedCol != null) {
      setState(() {
        // Mise à jour de la cellule sélectionnée
        puzzle.board()!.cellAt(Position(row: selectedRow!, column: selectedCol!)).setValue(value);
        board[selectedRow!][selectedCol!] = value;
      });
    }
  }

  List<int> _getBlockValues(int blockIndex) {
    List<int> values = [];
    int startRow = (blockIndex ~/ 3) * 3;
    int startCol = (blockIndex % 3) * 3;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        values.add(board[startRow + i][startCol + j]);
      }
    }
    return values;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double boxSize = (screenWidth < screenHeight ? screenWidth : screenHeight) * 0.6 / 3;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sudoku"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _generatePuzzle,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: boxSize * 3,
              width: boxSize * 3,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (context, x) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: InternalGrid(
                      boxSize: boxSize / 3,
                      values: _getBlockValues(x),
                      onCellTap: _onCellTap,
                      selectedRow: selectedRow,
                      selectedCol: selectedCol,
                      blockIndex: x,
                      puzzle: puzzle,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              alignment: WrapAlignment.center,
              children: List.generate(9, (index) {
                return ElevatedButton(
                  onPressed: () => _onNumberTap(index + 1),
                  child: Text('${index + 1}', style: const TextStyle(fontSize: 20)),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
