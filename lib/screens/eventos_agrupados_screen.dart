import 'package:flutter/material.dart';

import '../models/evento_calendario.dart';
import '../widgets/tarjeta_evento.dart';

class EventosAgrupadosScreen
    extends StatelessWidget {
  final String titulo;
  final Map<String,
      List<EventoCalendario>> grupos;

  const EventosAgrupadosScreen({
    super.key,
    required this.titulo,
    required this.grupos,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: ListView(
        children: grupos.entries
            .map(
              (grupo) => Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.all(
                      16,
                    ),
                    child: Text(
                      grupo.key,
                      style:
                          const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                  ...grupo.value.map(
                    (e) =>
                        TarjetaEvento(
                      color:
                          e.color,
                      texto:
                          e.titulo,
                    ),
                  ),
                  const Divider(),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}