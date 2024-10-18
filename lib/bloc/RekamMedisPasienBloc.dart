import 'dart:convert';
import 'package:manajemenkesehatan/helpers/api.dart';
import 'package:manajemenkesehatan/helpers/api_url.dart';
import 'package:manajemenkesehatan/model/rekam_medis_pasien.dart';

class RekamMedisPasienBloc {
  
  static Future<List<RekamMedisPasien>> getRekamMedisPasien() async {
    String apiUrl = ApiUrl.listRekamMedisPasien; 
    var response = await Api().get(apiUrl);

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      List<dynamic> listRekamMedisPasien = (jsonObj as Map<String, dynamic>)['data'];
      List<RekamMedisPasien> rekamMedisPasienList = [];

      for (var item in listRekamMedisPasien) {
        rekamMedisPasienList.add(RekamMedisPasien.fromJson(item));
      }
      return rekamMedisPasienList;
    } else {
      throw Exception('Failed to load rekam medis pasien');
    }
  }

  static Future<bool> addRekamMedisPasien({required RekamMedisPasien rekamMedisPasien}) async {
    String apiUrl = ApiUrl.createRekamMedisPasien; 
    var body = {
      "patient_name": rekamMedisPasien.patientName, 
      "symptom": rekamMedisPasien.symptom, 
      "severity": rekamMedisPasien.severity.toString() 
    };

    var response = await Api().post(apiUrl, body);
    
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'];
    } else {
      throw Exception('Failed to add rekam medis pasien');
    }
  }

  
  static Future<bool> updateRekamMedisPasien({required RekamMedisPasien rekamMedisPasien}) async {
    String apiUrl = ApiUrl.updateRekamMedisPasien(int.parse(rekamMedisPasien.id!)); 
    var body = {
      "patient_name": rekamMedisPasien.patientName,
      "symptom": rekamMedisPasien.symptom,
      "severity": rekamMedisPasien.severity.toString() 
    };

    var response = await Api().put(apiUrl, jsonEncode(body));
    
    
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'];
    } else {
      throw Exception('Failed to update rekam medis pasien');
    }
  }

  
  static Future<bool> deleteRekamMedisPasien({int? id}) async {
    String apiUrl = ApiUrl.deleteRekamMedisPasien(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
