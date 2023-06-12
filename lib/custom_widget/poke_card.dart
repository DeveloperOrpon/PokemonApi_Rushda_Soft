import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../Controller/api_controller.dart';
import '../model/card_model.dart';
import '../screen/poke_detail_screen.dart';

class PokeCard extends StatelessWidget {
  final CardModel poke;
  final BuildContext context;

  const PokeCard(this.poke, this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ApiController(),
        builder: (apiController) {
          return InkWell(
            onTap: () {
              Future.delayed(
                const Duration(seconds: 1),
                () {
                  Get.to(PokeDetailScreen(poke.id),
                      transition: Transition.fadeIn);
                },
              );
            },
            child: Obx(() {
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: apiController.color.value,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: const Offset(5, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: poke.id!,
                        child: CachedNetworkImage(
                          width: (Get.width / 2) - 20,
                          fit: BoxFit.fitWidth,
                          imageUrl: poke.sprite,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  const SpinKitSpinningLines(
                            color: Colors.pink,
                            size: 50.0,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '#${poke.type1}',
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(
                                (poke.name.toUpperCase()),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '#${poke.type1}',
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              (poke.name.toUpperCase()),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ).animate(onPlay: (controller) => controller.repeat()).shimmer(
                  duration: const Duration(seconds: 4),
                  color: Colors.indigoAccent.shade100.withOpacity(.3),
                  curve: Curves.fastLinearToSlowEaseIn);
            }),
          );
        });
  }
}
