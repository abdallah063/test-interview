import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:get/get.dart';
import '../model/local_json_model/item_model.dart';
class ServicesController extends GetxController {

  Future<List<ItemModel>> fetchItems() async {
    String jsonData = await rootBundle.loadString('assets/data.json');
    List<dynamic> jsonList = jsonDecode(jsonData)['items'];

    List<ItemModel> items = jsonList.map((item) => ItemModel.fromJson(item)).toList();
    return items;
  }

}

