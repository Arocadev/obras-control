import 'package:flutter/material.dart';

import '../models/obra.dart';
import '../models/pago.dart';
import '../services/storage_service.dart';

class PagosScreen extends StatefulWidget {
  const PagosScreen({
    super.key,
  });

  @override
  State<PagosScreen> createState() =>
      _PagosScreenState();
}

class _PagosScreenState
    extends State<PagosScreen> {
  List<Pago> pagos = [];
  List<Obra> obras = [];

  @override
  void initState() {
    super.initState();

    pagos =
        StorageService.cargarPagos();

    obras =
        StorageService.cargarObras();
  }

  Future<void> guardar() async {
    await StorageService
        .guardarPagos(
      pagos,
    );
  }

  Future<bool> confirmarEliminar(
    Pago pago,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title:
                  const Text(
                'Eliminar pago',
              ),
              content: Text(
                '¿Eliminar el pago de ${pago.persona}?',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      false,
                    );
                  },
                  child:
                      const Text(
                    'Cancelar',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      true,
                    );
                  },
                  child:
                      const Text(
                    'Eliminar',
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<void> eliminar(
    int index,
  ) async {
    pagos.removeAt(index);

    await guardar();

    setState(() {});
  }

  Future<void> crearPago({
    Pago? editar,
    int? indexEditar,
  }) async {
    final personaController =
        TextEditingController(
      text: editar?.persona ?? '',
    );

    final importeController =
        TextEditingController(
      text: editar == null
          ? ''
          : editar.importe.toString(),
    );

    DateTime fecha =
        editar?.fecha ??
            DateTime.now();

    Obra? obraSeleccionada;

    if (editar?.obraId != null) {
      try {
        obraSeleccionada =
            obras.firstWhere(
          (o) =>
              o.id ==
              editar!.obraId,
        );
      } catch (_) {}
    }

    String? tareaSeleccionada =
        editar?.tarea;

    await showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder:
              (
                context,
                setDialogState,
              ) {
            return AlertDialog(
              title: Text(
                editar == null
                    ? 'Nuevo pago'
                    : 'Editar pago',
              ),
              content:
                  SingleChildScrollView(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    TextField(
                      controller:
                          personaController,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Persona',
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller:
                          importeController,
                      keyboardType:
                          const TextInputType.numberWithOptions(
                        decimal:
                            true,
                      ),
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Importe',
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    DropdownButtonFormField<
                        Obra?>(
                      initialValue:
                          obraSeleccionada,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Obra',
                      ),
                      items: [
                        const DropdownMenuItem<
                            Obra?>(
                          value: null,
                          child:
                              Text(
                            'Ninguna',
                          ),
                        ),
                        ...obras.map(
                          (
                            obra,
                          ) {
                            return DropdownMenuItem<
                                Obra?>(
                              value:
                                  obra,
                              child:
                                  Text(
                                obra.nombre,
                              ),
                            );
                          },
                        ),
                      ],
                      onChanged:
                          (
                            value,
                          ) {
                        setDialogState(
                          () {
                            obraSeleccionada =
                                value;
                            tareaSeleccionada =
                                null;
                          },
                        );
                      },
                    ),
                    if (obraSeleccionada !=
                            null &&
                        obraSeleccionada!
                            .tareas
                            .isNotEmpty)
                      Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          DropdownButtonFormField<
                              String>(
                            initialValue:
                                tareaSeleccionada,
                            decoration:
                                const InputDecoration(
                              labelText:
                                  'Tarea',
                            ),
                            items:
                                obraSeleccionada!
                                    .tareas
                                    .map(
                                      (
                                        t,
                                      ) {
                                        return DropdownMenuItem(
                                          value:
                                              t.nombre,
                                          child:
                                              Text(
                                            t.nombre,
                                          ),
                                        );
                                      },
                                    )
                                    .toList(),
                            onChanged:
                                (
                                  value,
                                ) {
                              setDialogState(
                                () {
                                  tareaSeleccionada =
                                      value;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 12,
                    ),
                    ListTile(
                      contentPadding:
                          EdgeInsets.zero,
                      title:
                          const Text(
                        'Fecha',
                      ),
                      subtitle:
                          Text(
                        '${fecha.day}/${fecha.month}/${fecha.year}',
                      ),
                      trailing:
                          const Icon(
                        Icons.calendar_month,
                      ),
                      onTap:
                          () async {
                        final nueva =
                            await showDatePicker(
                          context:
                              context,
                          initialDate:
                              fecha,
                          firstDate:
                              DateTime(
                                  2020),
                          lastDate:
                              DateTime(
                                  2100),
                        );

                        if (nueva !=
                            null) {
                          setDialogState(
                            () {
                              fecha =
                                  nueva;
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed:
                      () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child:
                      const Text(
                    'Cancelar',
                  ),
                ),
                ElevatedButton(
                  onPressed:
                      () async {
                    if (personaController
                            .text
                            .trim()
                            .isEmpty ||
                        importeController
                            .text
                            .trim()
                            .isEmpty) {
                      return;
                    }

                    final importe =
                        double.tryParse(
                              importeController
                                  .text
                                  .replaceAll(
                                    ',',
                                    '.',
                                  ),
                            ) ??
                            0;

                    final pago =
                        Pago(
                      persona:
                          personaController
                              .text
                              .trim(),
                      importe:
                          importe,
                      fecha:
                          fecha,
                      obraId:
                          obraSeleccionada
                              ?.id,
                      tarea:
                          tareaSeleccionada,
                      pagado:
                          editar
                                  ?.pagado ??
                              false,
                    );

                    if (editar ==
                        null) {
                      pagos.add(
                        pago,
                      );
                    } else {
                      pagos[indexEditar!] =
                          pago;
                    }

                    await guardar();

                    if (mounted) {
                      setState(() {});
                      Navigator.pop(
                        context,
                      );
                    }
                  },
                  child:
                      const Text(
                    'Guardar',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final totalPagado =
        pagos
            .where(
              (p) =>
                  p.pagado,
            )
            .fold(
              0.0,
              (s, p) =>
                  s +
                  p.importe,
            );

    final totalPendiente =
        pagos
            .where(
              (p) =>
                  !p.pagado,
            )
            .fold(
              0.0,
              (s, p) =>
                  s +
                  p.importe,
            );

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Pagado:',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${totalPagado.toStringAsFixed(2)} €',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Pendiente:',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${totalPendiente.toStringAsFixed(2)} €',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                pagos.isEmpty
                    ? const Center(
                        child:
                            Text(
                          'No hay pagos',
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            pagos
                                .length,
                        itemBuilder:
                            (
                              context,
                              index,
                            ) {
                          final pago =
                              pagos[
                                  index];

                          Obra? obra;

                          try {
                            obra =
                                obras.firstWhere(
                              (
                                o,
                              ) =>
                                  o.id ==
                                  pago
                                      .obraId,
                            );
                          } catch (_) {}

                          return Card(
                            margin:
                                const EdgeInsets.symmetric(
                              horizontal:
                                  12,
                              vertical:
                                  6,
                            ),
                            child:
                                ListTile(
                              leading:
                                  Icon(
                                pago.pagado
                                    ? Icons.check_circle
                                    : Icons.schedule,
                                color:
                                    pago.pagado
                                        ? Colors.green
                                        : Colors.orange,
                              ),
                              title:
                                  Text(
                                'Persona: ${pago.persona}',
                              ),
                              subtitle:
                                  Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Importe: ${pago.importe.toStringAsFixed(2)} €',
                                  ),
                                  if (obra !=
                                      null)
                                    Text(
                                      'Obra: ${obra.nombre}',
                                    ),
                                  if (pago.tarea !=
                                      null)
                                    Text(
                                      'Tarea: ${pago.tarea}',
                                    ),
                                  Text(
                                    'Fecha: ${pago.fecha.day}/${pago.fecha.month}/${pago.fecha.year}',
                                  ),
                                ],
                              ),
                              trailing:
                                  PopupMenuButton<
                                      String>(
                                onSelected:
                                    (
                                      value,
                                    ) async {
                                  if (value ==
                                      'toggle') {
                                    setState(
                                      () {
                                        pago.pagado =
                                            !pago.pagado;
                                      },
                                    );

                                    await guardar();
                                  }

                                  if (value ==
                                      'edit') {
                                    await crearPago(
                                      editar:
                                          pago,
                                      indexEditar:
                                          index,
                                    );
                                  }

                                  if (value ==
                                      'delete') {
                                    final borrar =
                                        await confirmarEliminar(
                                      pago,
                                    );

                                    if (borrar) {
                                      await eliminar(
                                        index,
                                      );
                                    }
                                  }
                                },
                                itemBuilder:
                                    (_) =>
                                        [
                                  PopupMenuItem(
                                    value:
                                        'toggle',
                                    child:
                                        Text(
                                      pago.pagado
                                          ? 'Marcar pendiente'
                                          : 'Marcar pagado',
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value:
                                        'edit',
                                    child:
                                        Text(
                                      'Editar',
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value:
                                        'delete',
                                    child:
                                        Text(
                                      'Eliminar',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton(
        onPressed:
            crearPago,
        child:
            const Icon(
          Icons.add,
        ),
      ),
    );
  }
}