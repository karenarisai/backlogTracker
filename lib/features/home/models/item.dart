/* import 'package:flutter/material.dart'; */

class Item {
  final String title;
  final String categoria;
  bool completado;

  Item({
    required this.title,
    required this.categoria,
    this.completado = false,
  });
}
