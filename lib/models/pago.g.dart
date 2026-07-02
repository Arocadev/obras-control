// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pago.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PagoAdapter extends TypeAdapter<Pago> {
  @override
  final int typeId = 3;

  @override
  Pago read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pago(
      persona: fields[0] as String,
      importe: fields[1] as double,
      fecha: fields[2] as DateTime,
      obraId: fields[3] as String?,
      tarea: fields[4] as String?,
      pagado: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Pago obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.persona)
      ..writeByte(1)
      ..write(obj.importe)
      ..writeByte(2)
      ..write(obj.fecha)
      ..writeByte(3)
      ..write(obj.obraId)
      ..writeByte(4)
      ..write(obj.tarea)
      ..writeByte(5)
      ..write(obj.pagado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PagoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
