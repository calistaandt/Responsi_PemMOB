class JadwalVaksinasi {
  String? id;
  String? patientName;
  String? vaccineType;
  int? age; 
  DateTime? createdAt;
  DateTime? updatedAt;

  JadwalVaksinasi({
    this.id,
    this.patientName,
    this.vaccineType,
    this.age,
    this.createdAt,
    this.updatedAt,
  });

  factory JadwalVaksinasi.fromJson(Map<String, dynamic> obj) {
    return JadwalVaksinasi(
      id: obj['id']?.toString(),
      patientName: obj['person_name'],
      vaccineType: obj['vaccine_type'],
      age: obj['age'] is int ? obj['age'] : int.tryParse(obj['age']?.toString() ?? '') ?? 0, 
      createdAt: DateTime.parse(obj['created_at']),
      updatedAt: DateTime.parse(obj['updated_at']),
    );
  }
}
