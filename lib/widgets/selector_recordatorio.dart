import 'package:flutter/material.dart';

class SelectorRecordatorio
    extends StatelessWidget {
  final String texto;
  final bool valor;
  final ValueChanged<bool?>
      onChanged;

  const SelectorRecordatorio({
    super.key,
    required this.texto,
    required this.valor,
    required this.onChanged,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return CheckboxListTile(
      title: Text(texto),
      value: valor,
      onChanged: onChanged,
      controlAffinity:
          ListTileControlAffinity
              .leading,
    );
  }
}