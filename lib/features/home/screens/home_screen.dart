import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/home/models/item.dart';
import 'package:flutter_application_2/features/home/widgets/item_card.dart';

const List<String> categorias = [
  'Videojuego',
  'Libro',
  'Película',
  'Serie',
  'Música',
  'PC',
  'Consola',
  'Móvil',
];
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = [
    Item(title: 'Minecraft', categoria: 'Videojuego'),
    Item(title: 'Cien años de soledad', categoria: 'Libro'),
    Item(title: 'Interestelar', categoria: 'Película'),
    Item(title: 'Breaking Bad', categoria: 'Serie'),
    Item(title: 'Bohemian Rhapsody', categoria: 'Música'),
    Item(title: 'PC', categoria: 'PC'),
    Item(title: 'PlayStation 5', categoria: 'Consola'),
    Item(title: 'iPhone 13', categoria: 'Móvil'),
    Item(title: 'The Witcher 3', categoria: 'Videojuego'),
    Item(title: '1984', categoria: 'Libro'),
    Item(title: 'Inception', categoria: 'Película'),
    Item(title: 'Game of Thrones', categoria: 'Serie'),
  ];
  

  void _mostrarFormulario() {
    String newTitle = '';
    String categoriaSeleccionada = categorias.first;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Agregar nueva tarea'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Título'),
                    onChanged: (value) {
                      newTitle = value;
                    },
                  ),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Categoría'),
                  ),
                  DropdownButton<String>(
                    value: categoriaSeleccionada,
                    isExpanded: true,
                    alignment: AlignmentDirectional.centerStart,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
      underline: Container(height: 2, color: Colors.deepPurpleAccent),
                    items:categorias.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setDialogState(() {
                        categoriaSeleccionada = value ?? '';
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),

                ElevatedButton(
                  onPressed: () {
                    if (newTitle.isNotEmpty && categoriaSeleccionada.isNotEmpty) {
                      setState(() {
                        items.add(
                          Item(title: newTitle, categoria: categoriaSeleccionada),
                        );
                      });

                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        const SnackBar(
                          content: Text('Elemento agregado correctamente'),
                        ),
                      );
                    }
                  },
                  child: const Text('Agregar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 128, 216, 228),
        foregroundColor: Colors.white,
        title: const Text('Panel de actividades'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 5),

            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return Dismissible(
                    key: Key(item.title),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        items.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Elemento eliminado correctamente'),
                        ),
                      );
                    },
                    child: ItemCard(
                      item: item,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarFormulario,
        backgroundColor: const Color.fromARGB(255, 128, 216, 228),
        child: const Icon(Icons.add),
      ),
    );
  }
}
