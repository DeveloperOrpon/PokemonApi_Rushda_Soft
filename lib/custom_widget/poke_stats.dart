import 'package:flutter/material.dart';

import '../model/pokemon.dart';

class PokeStats extends StatelessWidget {
  final Pokemon pokeData;
  const PokeStats(this.pokeData, {super.key});

  String convertValue(value) {
    double initValue = value * 100;
    return initValue.toStringAsFixed(0);
  }

  Widget statsBar(String label, double progressValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.blue,
            ),
          ),
          const Spacer(),
          Text(
            convertValue(progressValue),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.blue,
            ),
          ),
          TweenAnimationBuilder(
              duration: const Duration(seconds: 1),
              curve: Curves.elasticInOut,
              tween: Tween(end: progressValue, begin: 0),
              builder: (context, value, child) {
                return Container(
                  width: 250,
                  height: 10,
                  margin: const EdgeInsets.only(left: 15),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.indigoAccent.shade400),
                      //(pokeData.type1)
                      value: value.toDouble(),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Column(
        children: [
          SizedBox(height: 15),
          statsBar('HP', pokeData.hp),
          statsBar('ATK', pokeData.attack),
          statsBar('DEF', pokeData.defense),
          statsBar('SATK', pokeData.spAttack),
          statsBar('SDEF', pokeData.spDefense),
          statsBar('SPD', pokeData.speed),
        ],
      ),
    );
  }
}
