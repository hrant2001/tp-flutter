import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart'; // Import the sudoku_api library
import 'internal_grid.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  late Puzzle puzzle;
  List<List<int>> board = List.generate(9, (_) => List.filled(9, 0)); // 9x9 grid initialized with 0s
  int? selectedRow; // To track the selected row
  int? selectedCol; // To track the selected column

  @override
  void initState() {
    super.initState();
    _generatePuzzle();
  }

  Future<void> _generatePuzzle() async {
    puzzle = Puzzle(PuzzleOptions(patternName: "winter"));
    await puzzle.generate(); // Generate the puzzle asynchronously

    setState(() {
      // Fill the board with values
      for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
          board[i][j] = puzzle.board()?.matrix()?[i][j].getValue() ?? 0;
        }
      }
    });
  }

  void _onCellTap(int row, int col) {
    setState(() {
      selectedRow = row;
      selectedCol = col;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double boxSize = (screenWidth < screenHeight ? screenWidth : screenHeight) * 0.6 / 3;

    return Scaffold(
      appBar: AppBar(title: const Text("Grille 3x3 avec sous-grilles")),
      body: Center(
        child: SizedBox(
          height: boxSize * 3,
          width: boxSize * 3,
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(9, (x) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: InternalGrid(
                  boxSize: boxSize / 3,
                  values: board[x], // Pass the row of values to InternalGrid
                  onCellTap: (row, col) {
                    _onCellTap(x, col); // Handle cell tap
                  },
                  isSelected: selectedRow == x, // Check if the cell is selected
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
