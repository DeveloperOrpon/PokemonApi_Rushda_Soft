import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/pokemon.dart';

class ViewDetailsController extends GetxController with StateMixin<Pokemon> {
  RxInt segmentedControlValue = RxInt(0);
  List<Pokemon> descList = [];
  Pokemon pokemon = Pokemon();
  Future<void> getPokeData(String id) async {
    List<Pokemon> tempDescList = [];
    Uri url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$id');
    Uri secUrl = Uri.parse('https://pokeapi.co/api/v2/pokemon-species/$id');
    try {
      final response = await http.get(url);
      final secResponse = await http.get(secUrl);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      final secResponseData =
          json.decode(secResponse.body) as Map<String, dynamic>;
      pokemon = Pokemon.fromJson(responseData, secResponseData);
      change(pokemon, status: RxStatus.success());
      descList = tempDescList;
      inspect(pokemon);
    } catch (e) {
      rethrow;
    }
  }
}
