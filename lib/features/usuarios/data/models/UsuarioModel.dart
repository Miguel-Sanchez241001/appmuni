import 'package:appmuni/core/errors/ValidationError.dart';

class UsuarioModel {
  final String id;
  final String nombre;
  final String correo;

  UsuarioModel({required this.id, required this.nombre, required this.correo});

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('id') || !json.containsKey('nombre') || !json.containsKey('correo')) {
      throw ValidationError("Los datos del usuario son inválidos.");
    }

    return UsuarioModel(
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'correo': correo,
    };
  }
}
