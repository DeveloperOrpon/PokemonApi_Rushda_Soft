import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pokemon/Controller/api_controller.dart';

import '../custom_widget/carosel_item_ui.dart';
import '../custom_widget/loadingWidget.dart';
import '../custom_widget/poke_card.dart';

class HomeScreen extends GetView<ApiController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      return RefreshIndicator(
        onRefresh: () async {
          controller.pokeNumber = 10;
          controller.refreshPage();
        },
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text("Animated Cartoon Hero"),
                centerTitle: true,
                floating: true,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                CarouselSlider(
                  options: CarouselOptions(
                    height: 255,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                  ),
                  items: state!.map((i) {
                    return HeroItem(
                      cardModel: i,
                    );
                  }).toList(),
                )
              ])),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(childCount: state.length,
                    (context, index) {
                  return PokeCard(state[index], context);
                }),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 350,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0),
              )
            ],
          ),
        ),
      );
    },
        onLoading: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              LoadingWidget(
                height: 150,
                color: Colors.grey.shade200,
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 350,
                            childAspectRatio: 3 / 4,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2),
                    itemCount: 8,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                          .animate(
                            delay: 1000.ms,
                            // this delay only happens once at the very start
                            onPlay: (controller) => controller.repeat(), // loop
                          )
                          .shimmer(duration: const Duration(seconds: 1));
                    }),
              ),
            ],
          ),
        ));
  }
}
