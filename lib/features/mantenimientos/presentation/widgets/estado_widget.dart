import 'package:appmuni/features/mantenimientos/presentation/viewmodels/estado_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EstadoWidget extends StatefulWidget {
  const EstadoWidget({Key? key}) : super(key: key);

  @override
  _EstadoWidgetState createState() => _EstadoWidgetState();
}

class _EstadoWidgetState extends State<EstadoWidget> {
  String _filtroEstado = 'Todos';

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EstadoViewModel>(context);

    return Column(
      children: [
        // Filtro de estado con botón de búsqueda
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: _buildFiltroEstadoDropdown(viewModel)),
            ElevatedButton(
              onPressed: () => viewModel.filtrarSolicitudes(_filtroEstado),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'Buscar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),

        // Lista de solicitudes filtradas
        Expanded(
          child: ListView.builder(
            itemCount: viewModel.solicitudesFiltradas.length,
            itemBuilder: (context, index) {
              final solicitud = viewModel.solicitudesFiltradas[index];
              final estadosDisponibles =
                  viewModel.estadosDisponibles(solicitud.estado);

              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Descripción: ${solicitud.descripcion}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      value: solicitud.estado,
                      items: estadosDisponibles.map((String estado) {
                        return DropdownMenuItem<String>(
                          value: estado,
                          child: Text(
                            estado,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (nuevoEstado) {
                        if (nuevoEstado != null &&
                            nuevoEstado != solicitud.estado) {
                          _mostrarConfirmacionCambioEstado(
                              context, solicitud, nuevoEstado, viewModel);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFiltroEstadoDropdown(EstadoViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: DropdownButton<String>(
        value: _filtroEstado,
        items: ['Todos', 'Pendiente', 'Completado', 'Aprobado', 'Rechazado']
            .map((String estado) {
          return DropdownMenuItem<String>(
            value: estado,
            child: Text(estado),
          );
        }).toList(),
        onChanged: (nuevoFiltro) {
          setState(() {
            _filtroEstado = nuevoFiltro!;
          });
        },
      ),
    );
  }

  void _mostrarConfirmacionCambioEstado(
    BuildContext context,
    SolicitudEstado solicitud,
    String nuevoEstado,
    EstadoViewModel viewModel,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Confirmar Cambio de Estado',
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
            '¿Estás seguro de cambiar el estado a "$nuevoEstado"?',
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                viewModel.cambiarEstado(solicitud.id, nuevoEstado);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Estado cambiado a "$nuevoEstado".'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child:
                  const Text('Aceptar', style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }
}
