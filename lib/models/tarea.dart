import 'package:hive/hive.dart';

part 'tarea.g.dart';

@HiveType(typeId: 0)
class Tarea extends HiveObject {
  @HiveField(0)
  String nombre;

  @HiveField(1)
  bool hecha;

  Tarea({
    required this.nombre,
    this.hecha = false,
  });
}