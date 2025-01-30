import 'package:flutter/material.dart';
import 'internal_grid.dart'; // Import du fichier séparé

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

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
                child: InternalGrid(boxSize: boxSize / 3), // Ajout de la grille interne
              );
            }),
          ),
        ),
      ),
    );
  }
}
