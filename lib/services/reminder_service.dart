import 'package:hive/hive.dart';

import '../models/recordatorio.dart';
import 'notification_service.dart';
import 'storage_service.dart';

class ReminderService {
  static List<Recordatorio>
      cargar() {
    final box =
        Hive.box<Recordatorio>(
      StorageService
          .recordatoriosBox,
    );

    return box.values.toList();
  }

  static Future<void> guardar(
    Recordatorio r,
  ) async {
    final box =
        Hive.box<Recordatorio>(
      StorageService
          .recordatoriosBox,
    );

    await box.add(r);

    final baseId =
        DateTime.now()
            .millisecondsSinceEpoch %
        1000000000;

    // 1 día antes
    if (r.avisarDiaAntes) {
      final fecha =
          r.fecha.subtract(
        const Duration(
          days: 1,
        ),
      );

      if (fecha.isAfter(
        DateTime.now(),
      )) {
        await NotificationService
            .programarNotificacion(
          id: baseId,
          titulo:
              'Recordatorio',
          cuerpo:
              r.titulo,
          fecha: fecha,
        );
      }
    }

    // 6 horas antes
    if (r.avisar6HorasAntes) {
      final fecha =
          r.fecha.subtract(
        const Duration(
          hours: 6,
        ),
      );

      if (fecha.isAfter(
        DateTime.now(),
      )) {
        await NotificationService
            .programarNotificacion(
          id: baseId + 1,
          titulo:
              'Recordatorio',
          cuerpo:
              r.titulo,
          fecha: fecha,
        );
      }
    }

    // 1 hora antes
    if (r.avisar1HoraAntes) {
      final fecha =
          r.fecha.subtract(
        const Duration(
          hours: 1,
        ),
      );

      if (fecha.isAfter(
        DateTime.now(),
      )) {
        await NotificationService
            .programarNotificacion(
          id: baseId + 2,
          titulo:
              'Recordatorio',
          cuerpo:
              r.titulo,
          fecha: fecha,
        );
      }
    }

    // Hora exacta
    if (r.fecha.isAfter(
      DateTime.now(),
    )) {
      await NotificationService
          .programarNotificacion(
        id: baseId + 3,
        titulo:
            'Recordatorio',
        cuerpo:
            r.titulo,
        fecha: r.fecha,
      );
    }
  }

  static Future<void> eliminar(
    int index,
  ) async {
    final box =
        Hive.box<Recordatorio>(
      StorageService
          .recordatoriosBox,
    );

    await box.deleteAt(index);
  }

  static Future<void> actualizar(
    int index,
    Recordatorio r,
  ) async {
    final box =
        Hive.box<Recordatorio>(
      StorageService
          .recordatoriosBox,
    );

    await box.putAt(
      index,
      r,
    );
  }
}