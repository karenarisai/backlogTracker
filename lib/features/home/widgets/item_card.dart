import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/details/screens/detail_screen.dart';
import 'package:flutter_application_2/features/home/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ItemCard extends StatefulWidget {
  final Item item;

  const ItemCard({
    super.key,
    required this.item,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    _cargarEstado();
  }

  Future<void> _cargarEstado() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isCompleted = prefs.getBool(widget.item.title) ?? false;
    });
  }

  Future<void> _guardarEstado() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.item.title, isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isCompleted ? Colors.green.shade100 : Colors.white,
      elevation: 2,
      child: ListTile(
        title: Text(widget.item.title),
        subtitle: Text(
          isCompleted ? 'Completado!' : widget.item.categoria,
        ),
        onTap: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailScreen(
                item: widget.item,
              ),
            ),
          );
        },
        trailing: IconButton(
          onPressed: () {
            setState(() {
              isCompleted = !isCompleted;
            });
            _guardarEstado();
          },
          icon: Icon(
            isCompleted
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: isCompleted ? Colors.green : Colors.grey,
          ),
        ),
      ),
    );
  }
}