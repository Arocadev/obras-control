import 'package:hive/hive.dart';

part 'cobro.g.dart';

@HiveType(typeId: 4)
class Cobro extends HiveObject {
  @HiveField(0)
  String obraId;

  @HiveField(1)
  double importe;

  @HiveField(2)
  DateTime fecha;

  @HiveField(3)
  String concepto;

  Cobro({
    required this.obraId,
    required this.importe,
    required this.fecha,
    this.concepto = '',
  });
}