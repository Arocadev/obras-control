import 'package:hive/hive.dart';
import '../models/obra.dart';

class StorageService {
  static const String obrasBox =
      'obras_box';

  static Future<void> guardarObras(
      List<Obra> obras) async {
    final box =
        Hive.box<Obra>(obrasBox);

    await box.clear();

    for (final obra in obras) {
      await box.add(obra);
    }
  }

  static List<Obra> cargarObras() {
    final box =
        Hive.box<Obra>(obrasBox);

    return box.values.toList();
  }
}