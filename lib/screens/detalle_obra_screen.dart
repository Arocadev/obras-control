import 'package:flutter/material.dart';
import '../models/obra.dart';

class DetalleObraScreen extends StatelessWidget {
  final Obra obra;

  const DetalleObraScreen({
    super.key,
    required this.obra,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(obra.nombre),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.task),
              title: const Text('Tareas'),
              subtitle: const Text('0 tareas'),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Materiales'),
              subtitle: const Text('0 materiales'),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.euro),
              title: const Text('Cobrado'),
              subtitle: const Text('0 €'),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Presupuesto'),
              subtitle: const Text('0 €'),
            ),
          ),
        ],
      ),
    );
  }
}