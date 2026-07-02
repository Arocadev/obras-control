// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obra.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ObraAdapter extends TypeAdapter<Obra> {
  @override
  final int typeId = 2;

  @override
  Obra read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Obra(
      nombre: fields[0] as String,
      presupuesto: fields[1] as double,
      cobrado: fields[2] as double,
      tareas: (fields[3] as List?)?.cast<Tarea>(),
      materiales: (fields[4] as List?)?.cast<MaterialObra>(),
    );
  }

  @override
  void write(BinaryWriter writer, Obra obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.presupuesto)
      ..writeByte(2)
      ..write(obj.cobrado)
      ..writeByte(3)
      ..write(obj.tareas)
      ..writeByte(4)
      ..write(obj.materiales);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObraAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
