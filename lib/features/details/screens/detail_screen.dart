import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/home/models/item.dart';

class DetailScreen extends StatelessWidget {
  final Item item;

  const DetailScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: const Color.fromARGB(255, 128, 216, 228),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              item.categoria,
              style: const TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 57, 32, 71),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}