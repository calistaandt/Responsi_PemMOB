import 'dart:convert';
import 'package:manajemenkesehatan/helpers/api.dart';
import 'package:manajemenkesehatan/helpers/api_url.dart';
import 'package:manajemenkesehatan/model/nutrisi.dart';

class NutrisiBloc {
  static Future<List<Nutrisi>> getNutrisi() async {
    String apiUrl = ApiUrl.listNutrisi;
    var response = await Api().get(apiUrl);
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      List<dynamic> listNutrisi = (jsonObj as Map<String, dynamic>)['data'];
      List<Nutrisi> nutrisiList = [];

      for (var item in listNutrisi) {
        nutrisiList.add(Nutrisi.fromJson(item));
      }
      return nutrisiList;
    } else {
      throw Exception('Failed to load nutrisi');
    }
  }

  static Future<bool> addNutrisi({required Nutrisi nutrisi}) async {
    String apiUrl = ApiUrl.createNutrisi;
    var body = {
      "food_item": nutrisi.foodItem,
      "calories": nutrisi.calories,
      "fat_content": nutrisi.fatContent.toString()
    };
    var response = await Api().post(apiUrl, body);
    
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'];
    } else {
      throw Exception('Failed to add nutrisi');
    }
  }

  static Future<bool> updateNutrisi({required Nutrisi nutrisi}) async {
    String apiUrl = ApiUrl.updateNutrisi(nutrisi.id!);
    var body = {
      "food_item": nutrisi.foodItem,
      "calories": nutrisi.calories,
      "fat_content": nutrisi.fatContent.toString()
    };

    var response = await Api().put(apiUrl, jsonEncode(body));
    
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'];
    } else {
      throw Exception('Failed to update nutrisi');
    }
  }

  static Future<bool> deleteNutrisi({int? id}) async {
    String apiUrl = ApiUrl.deleteNutrisi(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
