import 'package:hive/hive.dart';

import '../models/recordatorio.dart';
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