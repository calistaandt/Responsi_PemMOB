import 'dart:convert';
import 'package:manajemenkesehatan/helpers/api.dart';
import 'package:manajemenkesehatan/helpers/api_url.dart';
import 'package:manajemenkesehatan/model/jadwal_vaksinasi.dart';

class JadwalVaksinasiBloc {
  static Future<List<JadwalVaksinasi>> getJadwalVaksinasi() async {
    String apiUrl = ApiUrl.listJadwalVaksinasi;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listJadwalVaksinasi = (jsonObj as Map<String, dynamic>)['data'];
    List<JadwalVaksinasi> jadwalVaksinasiList = [];

    for (var item in listJadwalVaksinasi) {
      jadwalVaksinasiList.add(JadwalVaksinasi.fromJson(item));
    }
    return jadwalVaksinasiList;
  }

  static Future<bool> addJadwalVaksinasi(JadwalVaksinasi jadwal) async {
    String apiUrl = ApiUrl.createJadwalVaksinasi;
    var body = {
      "person_name": jadwal.patientName,
      "vaccine_type": jadwal.vaccineType,
      "age": jadwal.age,
      "created_at": jadwal.createdAt?.toIso8601String(),
      "updated_at": jadwal.updatedAt?.toIso8601String(),
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateJadwalVaksinasi(JadwalVaksinasi jadwal) async {
    String apiUrl = ApiUrl.updateJadwalVaksinasi(int.parse(jadwal.id!));
    var body = {
      "person_name": jadwal.patientName,
      "vaccine_type": jadwal.vaccineType,
      "age": jadwal.age,
      "created_at": jadwal.createdAt?.toIso8601String(),
      "updated_at": jadwal.updatedAt?.toIso8601String(),
    };
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteJadwalVaksinasi(int id) async {
    String apiUrl = ApiUrl.deleteJadwalVaksinasi(id);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }
}
