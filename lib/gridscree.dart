import 'package:flutter/material.dart';

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupérer les dimensions de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Définir la taille maximale de la grille (moitié de l'écran)
    double boxSize = (screenWidth < screenHeight ? screenWidth : screenHeight) / 6;

    return Scaffold(
      appBar: AppBar(title: const Text("Grille 3x3 en Flutter")),
      body: Center(
        child: SizedBox(
          height: boxSize * 3,
          width: boxSize * 3,
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(9, (x) {
              return Container(
                width: boxSize,
                height: boxSize,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }}