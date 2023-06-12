import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/card_model.dart';

class ApiController extends GetxController with StateMixin<List<CardModel>> {
  Rx<Color> color = Rx<Color>(Colors.indigo.shade400);
  int pokeNumber = (10);
  @override
  void onInit() {
    getHomeData();
    super.onInit();
  }

  Future<void> getHomeData() async {
    List<CardModel> tempList = [];
    for (int index = 1; index < pokeNumber + 1; index++) {
      int pokeIndex;
      Random rnd;
      int min = 1;
      int max = 893;
      rnd = Random();
      pokeIndex = min + rnd.nextInt(max - min);
      try {
        Uri url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokeIndex');
        final response = await http.get(url);
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        tempList.add(CardModel.fromJson(responseData));
        change(tempList, status: RxStatus.success());
      } catch (e) {
        rethrow;
      }
    }
  }

  void refreshPage() {
    change([], status: RxStatus.loading());
    getHomeData();
  }
}
