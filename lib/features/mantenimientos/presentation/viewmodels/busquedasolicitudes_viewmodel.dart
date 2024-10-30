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
  String _marca = 'VASTEC COMMANDER G8';
  String _monitor = 'Seleccione';
  String _teclado = 'Seleccione';
  String _prioridadBuscada = 'Todos';
  String _numSerie = '';
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
  String get marca => _marca;
  String get numSerie => _numSerie;
  String get monitor => _monitor;

  String get teclado => _teclado;

  void setNombreBuscado(String nombre) {
    _nombreBuscado = nombre;
    notifyListeners();
  }

  void setDepartamentoBuscado(String departamento) {
    _departamentoBuscado = departamento;
    notifyListeners();
  }

  void setNumeroSerie(String numSerie) {
    _numSerie = numSerie;
    notifyListeners();
  }

  void setPrioridadBuscada(String prioridad) {
    _prioridadBuscada = prioridad;
    notifyListeners();
  }

  void setMarca(String marca) {
    _marca = marca;
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
