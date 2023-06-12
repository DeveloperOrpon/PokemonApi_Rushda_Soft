import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pokemon/Controller/view_detalis_controller.dart';

import '../custom_widget/loadingWidget.dart';
import '../custom_widget/poke_about.dart';
import '../custom_widget/poke_moves.dart';
import '../custom_widget/poke_stats.dart';

class PokeDetailScreen extends GetView<ViewDetailsController> {
  final String pokeId;

  const PokeDetailScreen(this.pokeId, {super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewDetailsController()).getPokeData(pokeId);
    return controller.obx((state) {
      final pokeData = state!;
      return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(
                    "About ${pokeData.name[0].toUpperCase() + pokeData.name.substring(1)}"),
                floating: true,
                expandedHeight: 220,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(top: 45.0),
                    child: Hero(
                      tag: pokeData.id!,
                      child: CachedNetworkImage(
                        height: 150,
                        imageUrl: pokeData.sprite,
                        fit: BoxFit.fitHeight,
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
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(top: 5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${pokeData.name[0].toUpperCase() + pokeData.name.substring(1)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 35,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          width: Get.width,
                          child: FittedBox(
                            child: Text(
                              pokeData.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Obx(() {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.indigoAccent, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CupertinoSlidingSegmentedControl(
                              backgroundColor: Colors.white,
                              thumbColor: Colors.indigoAccent,
                              groupValue:
                                  controller.segmentedControlValue.value,
                              children: {
                                0: Container(
                                  alignment: Alignment.center,
                                  width: Get.width,
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 10, right: 20, bottom: 10),
                                  child: Text(
                                    "ABOUT",
                                    style: TextStyle(
                                        color: controller.segmentedControlValue
                                                    .value ==
                                                0
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16),
                                  ),
                                ),
                                1: Container(
                                  alignment: Alignment.center,
                                  width: Get.width,
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 10, right: 20, bottom: 10),
                                  child: Text(
                                    "STATS",
                                    style: TextStyle(
                                        color: controller.segmentedControlValue
                                                    .value ==
                                                1
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16),
                                  ),
                                ),
                                2: Container(
                                  alignment: Alignment.center,
                                  width: Get.width,
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 10, right: 20, bottom: 10),
                                  child: Text(
                                    "MOVES",
                                    style: TextStyle(
                                        color: controller.segmentedControlValue
                                                    .value ==
                                                2
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16),
                                  ),
                                ),
                              },
                              onValueChanged: (value) {
                                controller.segmentedControlValue.value = value!;
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Obx(() {
                    return controller.segmentedControlValue.value == 0
                        ? PokeAbout(pokeData)
                        : controller.segmentedControlValue.value == 1
                            ? PokeStats(pokeData)
                            : PokeMoves(pokeData);
                  })
                ]),
              ),
            ],
          ));
    },
        onLoading: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              LoadingWidget(height: 200, color: Colors.grey.shade200),
              const LoadingWidget(height: 100, color: Colors.white),
              LoadingWidget(height: 50, color: Colors.blue.shade100),
              LoadingWidget(height: 300, color: Colors.grey.shade200),
            ],
          ),
        ));
  }
}

Widget moveLabel(String text, dynamic pokeData) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.indigoAccent,
      borderRadius: BorderRadius.circular(15),
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
