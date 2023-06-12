import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class LoadingWidget extends StatelessWidget {
  final double height;
  final Color color;
  const LoadingWidget({Key? key, required this.height, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
      height: height,
      width: Get.width,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .shimmer(duration: const Duration(seconds: 1));
  }
}
