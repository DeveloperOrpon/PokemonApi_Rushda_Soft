import 'package:flutter/material.dart';

import '../model/pokemon.dart';

class PokeMoves extends StatelessWidget {
  final Pokemon pokeData;
  const PokeMoves(this.pokeData, {super.key});

  Widget moveLabel(String text, dynamic pokeData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigoAccent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          (text),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 7,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List? moveList = pokeData.moves;
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: IgnorePointer(
        ignoringSemantics: true,
        child: GridView.count(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          childAspectRatio: 6 / 1.5,
          crossAxisSpacing: 4,
          children: moveList!.map((item) => moveLabel(item, pokeData)).toList(),
        ),
      ),
    );
  }
}
