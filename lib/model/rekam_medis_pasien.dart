class RekamMedisPasien {
  String? id;
  String? patientName;
  String? symptom;
  int? severity;
  DateTime? createdAt;
  DateTime? updatedAt;

  RekamMedisPasien({
    this.id,
    this.patientName,
    this.symptom,
    this.severity,
    this.createdAt,
    this.updatedAt,
  });

  factory RekamMedisPasien.fromJson(Map<String, dynamic> obj) {
    return RekamMedisPasien(
      id: obj['id']?.toString(),
      patientName: obj['patient_name'],
      symptom: obj['symptom'],
      severity: obj['severity'] is int ? obj['severity'] : int.parse(obj['severity']),
      createdAt: obj['created_at'] != null ? DateTime.parse(obj['created_at']) : null,
      updatedAt: obj['updated_at'] != null ? DateTime.parse(obj['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_name': patientName,
      'symptom': symptom,
      'severity': severity.toString(),
    };
  }
}
