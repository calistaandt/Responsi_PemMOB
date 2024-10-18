import 'package:flutter/material.dart';
import 'package:manajemenkesehatan/model/nutrisi.dart';

class NutrisiDetail extends StatelessWidget {
  final Nutrisi nutrisi;

  const NutrisiDetail({Key? key, required this.nutrisi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nutrisi.foodItem),
        backgroundColor: const Color.fromARGB(255, 7, 230, 92),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Makanan:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              nutrisi.foodItem,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Kalori:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '${nutrisi.calories} kcal',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Konten Lemak:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '${nutrisi.fatContent} gram',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            // You can add more nutritional information here if available
            Text(
              'Informasi Nutrisi Lainnya:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement any action for the button, if needed
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
