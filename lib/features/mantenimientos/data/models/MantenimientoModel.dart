import '../../../../core/errors/ValidationError.dart';

class MantenimientoModel {
  final String id;
  final String descripcion;
  final DateTime fecha;

  MantenimientoModel({required this.id, required this.descripcion, required this.fecha});

  factory MantenimientoModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('id') || !json.containsKey('descripcion') || !json.containsKey('fecha')) {
      throw ValidationError("Los datos del mantenimiento son inválidos.");
    }

    return MantenimientoModel(
      id: json['id'],
      descripcion: json['descripcion'],
      fecha: DateTime.parse(json['fecha']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descripcion': descripcion,
      'fecha': fecha.toIso8601String(),
    };
  }
}
