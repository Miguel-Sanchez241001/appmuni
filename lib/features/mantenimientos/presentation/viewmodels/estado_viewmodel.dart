import 'package:flutter/material.dart';

class SolicitudEstado {
  final int id;
  final String descripcion;
  String estado;

  SolicitudEstado({
    required this.id,
    required this.descripcion,
    required this.estado,
  });
}

class EstadoViewModel extends ChangeNotifier {
  final List<SolicitudEstado> _solicitudes = [
    SolicitudEstado(
        id: 1, descripcion: 'Reparación de impresora', estado: 'Pendiente'),
    SolicitudEstado(
        id: 2, descripcion: 'Actualizar software', estado: 'Completado'),
    SolicitudEstado(id: 3, descripcion: 'Revisión de red', estado: 'Aprobado'),
    SolicitudEstado(
        id: 4, descripcion: 'Instalación de equipo', estado: 'Pendiente'),
  ];

  List<SolicitudEstado> _solicitudesFiltradas = [];

  List<SolicitudEstado> get solicitudesFiltradas => _solicitudesFiltradas;

  EstadoViewModel() {
    _solicitudesFiltradas = List.from(_solicitudes);
  }

  void filtrarSolicitudes(String estadoFiltro) {
    if (estadoFiltro == 'Todos') {
      _solicitudesFiltradas = List.from(_solicitudes);
    } else {
      _solicitudesFiltradas = _solicitudes
          .where((solicitud) => solicitud.estado == estadoFiltro)
          .toList();
    }
    notifyListeners();
  }

  void cambiarEstado(int id, String nuevoEstado) {
    final solicitud =
        _solicitudes.firstWhere((solicitud) => solicitud.id == id);
    solicitud.estado = nuevoEstado;
    notifyListeners();
  }

  List<String> estadosDisponibles(String estadoActual) {
    if (estadoActual == 'Pendiente') {
      return ['Pendiente', 'Completado'];
    } else if (estadoActual == 'Completado') {
      return ['Completado', 'Aprobado', 'Rechazado'];
    }
    return ['Aprobado', 'Rechazado'];
  }
}
