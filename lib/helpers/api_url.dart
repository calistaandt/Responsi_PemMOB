class ApiUrl {
  static const String baseUrl = 'http://103.196.155.42/api';
  static const String registrasi = '$baseUrl/registrasi';
  static const String login = '$baseUrl/login';
  static const String listRekamMedisPasien = '$baseUrl/kesehatan/rekam_medis_pasien'; 
  static const String createRekamMedisPasien = '$baseUrl/kesehatan/rekam_medis_pasien'; 

  static String updateRekamMedisPasien(int id) {
    return '$baseUrl/kesehatan/rekam_medis_pasien/$id/update'; 
  }

  static String showRekamMedisPasien(int id) {
    return '$baseUrl/kesehatan/rekam_medis_pasien/$id'; 
  }

  static String deleteRekamMedisPasien(int id) {
    return '$baseUrl/kesehatan/rekam_medis_pasien/$id/delete'; 
  }

  static const String listJadwalVaksinasi = '$baseUrl/kesehatan/jadwal_vaksinasi';
  static const String createJadwalVaksinasi = '$baseUrl/kesehatan/jadwal_vaksinasi';
  
  static String updateJadwalVaksinasi(int id) {
    return '$baseUrl/kesehatan/jadwal_vaksinasi/$id'; 
  }

  static String deleteJadwalVaksinasi(int id) {
    return '$baseUrl/kesehatan/jadwal_vaksinasi/$id';
  }

  static const String listNutrisi = '$baseUrl/kesehatan/nutrisi';
  static const String createNutrisi = '$baseUrl/kesehatan/nutrisi';
  
  static String updateNutrisi(int id) {
    return '$baseUrl/kesehatan/nutrisi/$id'; 
  }

  static String deleteNutrisi(int id) {
    return '$baseUrl/kesehatan/nutrisi/$id';
  }

}
