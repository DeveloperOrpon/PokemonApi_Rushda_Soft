import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

import '../model/card_model.dart';
import '../screen/poke_detail_screen.dart';

class HeroItem extends StatelessWidget {
  const HeroItem({
    Key? key,
    required this.cardModel,
  }) : super(key: key);
  final CardModel cardModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(PokeDetailScreen(cardModel.id), transition: Transition.fadeIn);
      },
      child: Container(
        width: 350,
        height: 400,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        decoration: BoxDecoration(
          color: Colors.indigoAccent.withOpacity(.7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                height: 320,
                fit: BoxFit.cover,
                imageUrl: cardModel.sprite,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    const SpinKitSpinningLines(
                  color: Colors.pink,
                  size: 50.0,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: _buildInfoGlass(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoGlass() {
    return GlassContainer(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      //  width: width - 50,
      blur: 10,
      opacity: 0.15,
      shadowColor: Colors.grey.shade300,
      child: Container(
        width: 350,
        height: 80,
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: _buildInfo(),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      children: [
        Text(
          '#${cardModel.id} : #${cardModel.type1},#${cardModel.type2}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          cardModel.name.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
