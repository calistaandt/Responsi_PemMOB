class Nutrisi {
  final int? id;
  final String foodItem;
  final int calories;
  final double fatContent;

  Nutrisi({
    this.id,
    required this.foodItem,
    required this.calories,
    required this.fatContent,
  });

  factory Nutrisi.fromJson(Map<String, dynamic> json) {
    return Nutrisi(
      id: json['id'],
      foodItem: json['food_item'],
      calories: json['calories'],
      fatContent: json['fat_content'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'food_item': foodItem,
      'calories': calories,
      'fat_content': fatContent,
    };
  }
}
