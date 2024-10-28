import 'package:flutter/material.dart';

class SolicitudMantenimiento {
  final String nombreSolicitante;
  final String departamento;
  final String descripcion;
  final String prioridad;

  SolicitudMantenimiento({
    required this.nombreSolicitante,
    required this.departamento,
    required this.descripcion,
    required this.prioridad,
  });
}

class BusquedaMantenimientoViewModel extends ChangeNotifier {
  String _nombreBuscado = '';
  String _departamentoBuscado = '';
  String _prioridadBuscada =
      'Todos'; // Establece el valor predeterminado en "Todos"

  List<SolicitudMantenimiento> _resultadosBusqueda = [];

  // Datos de prueba
  final List<SolicitudMantenimiento> _solicitudes = [
    SolicitudMantenimiento(
      nombreSolicitante: 'Juan Perez',
      departamento: 'TI',
      descripcion: 'Reparación de impresora',
      prioridad: 'Alta',
    ),
    SolicitudMantenimiento(
      nombreSolicitante: 'Ana Gomez',
      departamento: 'Finanzas',
      descripcion: 'Actualización de software',
      prioridad: 'Media',
    ),
    SolicitudMantenimiento(
      nombreSolicitante: 'Carlos Ruiz',
      departamento: 'Recursos Humanos',
      descripcion: 'Problema con la red',
      prioridad: 'Baja',
    ),
  ];

  List<SolicitudMantenimiento> get resultadosBusqueda => _resultadosBusqueda;
  String get prioridadBuscada => _prioridadBuscada;

  void setNombreBuscado(String nombre) {
    _nombreBuscado = nombre;
    notifyListeners();
  }

  void setDepartamentoBuscado(String departamento) {
    _departamentoBuscado = departamento;
    notifyListeners();
  }

  void setPrioridadBuscada(String prioridad) {
    _prioridadBuscada = prioridad;
    notifyListeners();
  }

  void resetBusqueda() {
    _nombreBuscado = '';
    _departamentoBuscado = '';
    _prioridadBuscada = 'Todos';
    _resultadosBusqueda = [];
    notifyListeners();
  }

  void buscarSolicitudes() {
    print("Buscando..."); // Mensaje en consola

    // Si todos los filtros están vacíos o en "Todos", devuelve todas las solicitudes
    if (_nombreBuscado.isEmpty &&
        _departamentoBuscado.isEmpty &&
        _prioridadBuscada == 'Todos') {
      _resultadosBusqueda = List.from(
          _solicitudes); // Clonamos la lista para evitar referencias directas
    } else {
      _resultadosBusqueda = _solicitudes.where((solicitud) {
        final coincideNombre = _nombreBuscado.isEmpty ||
            solicitud.nombreSolicitante
                .toLowerCase()
                .contains(_nombreBuscado.toLowerCase());
        final coincideDepartamento = _departamentoBuscado.isEmpty ||
            solicitud.departamento
                .toLowerCase()
                .contains(_departamentoBuscado.toLowerCase());
        final coincidePrioridad = _prioridadBuscada == 'Todos' ||
            solicitud.prioridad.toLowerCase() ==
                _prioridadBuscada.toLowerCase();

        return coincideNombre && coincideDepartamento && coincidePrioridad;
      }).toList();
    }

    notifyListeners();
  }
}
