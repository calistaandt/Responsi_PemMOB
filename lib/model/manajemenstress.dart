class ManajemenStress {
  int? id;
  String? stressFaktor;
  String? copingStrategy;
  int? stressLevel;
  ManajemenStress({this.id, this.stressFaktor, this.copingStrategy, this.stressLevel});
  factory ManajemenStress.fromJson(Map<String, dynamic> obj) {
    return ManajemenStress(
        id: obj['id'],
        stressFaktor: obj['stress_factor'],
        copingStrategy: obj['coping_strategy'],
        stressLevel: obj['stress_level']);
  }
}
