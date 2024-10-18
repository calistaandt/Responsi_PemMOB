import 'dart:convert';
import 'package:manajemenkesehatan/helpers/api.dart';
import 'package:manajemenkesehatan/helpers/api_url.dart';
import 'package:manajemenkesehatan/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi(
      {String? nama, String? email, String? password}) async {
    String apiUrl = ApiUrl.registrasi;
    var body = {"nama": nama, "email": email, "password": password};
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return Registrasi.fromJson(jsonObj);
  }
}
