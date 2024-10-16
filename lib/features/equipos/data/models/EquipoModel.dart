
import 'package:appmuni/core/errors/ValidationError.dart';

class EquipoModel {
  final String id;
  final String nombre;

  EquipoModel({required this.id, required this.nombre});

  factory EquipoModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('id') || !json.containsKey('nombre')) {
      throw ValidationError("Los datos del equipo son inválidos.");
    }

    return EquipoModel(
      id: json['id'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }
}
