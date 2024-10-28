import 'dart:io';
import 'package:appmuni/features/mantenimientos/presentation/viewmodels/busquedasolicitudes_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';

class BusquedaMantenimientoWidget extends StatefulWidget {
  const BusquedaMantenimientoWidget({super.key});

  @override
  _BusquedaMantenimientoWidgetState createState() =>
      _BusquedaMantenimientoWidgetState();
}

class _BusquedaMantenimientoWidgetState
    extends State<BusquedaMantenimientoWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BusquedaMantenimientoViewModel>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white, // Fondo blanco para el formulario
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Buscar Solicitudes de Mantenimiento',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Nombre del Solicitante',
                onChanged: (value) => viewModel.setNombreBuscado(value),
              ),
              _buildTextField(
                label: 'Departamento',
                onChanged: (value) => viewModel.setDepartamentoBuscado(value),
              ),
              _buildDropdown(
                label: 'Prioridad',
                items: ['Todos', 'Alta', 'Media', 'Baja'],
                value: viewModel.prioridadBuscada,
                onChanged: (value) => viewModel.setPrioridadBuscada(value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  viewModel.buscarSolicitudes();
                  print("Buscando..."); // Mensaje en consola para depuración
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Buscar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              viewModel.resultadosBusqueda.isNotEmpty
                  ? _buildResultados(context, viewModel)
                  : const Center(
                      child: Text(
                        'No se encontraron solicitudes',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required ValueChanged<String> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.red),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<String> items,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.red)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: Container(),
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildResultados(
      BuildContext context, BusquedaMantenimientoViewModel viewModel) {
    return SizedBox(
      height: 250, // Fija una altura para el carrusel
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.resultadosBusqueda.length,
        itemBuilder: (context, index) {
          final solicitud = viewModel.resultadosBusqueda[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.white, // Fondo blanco
              borderRadius: BorderRadius.circular(16), // Bordes redondeados
            ),
            child: _buildSolicitudCard(context, solicitud),
          );
        },
      ),
    );
  }

  Widget _buildSolicitudCard(
      BuildContext context, SolicitudMantenimiento solicitud) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white, // Fondo blanco
          borderRadius: BorderRadius.circular(16), // Bordes redondeados
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              solicitud.nombreSolicitante,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red),
            ),
            Text(solicitud.departamento),
            Text('Descripción: ${solicitud.descripcion}'),
            Text('Prioridad: ${solicitud.prioridad}'),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                _verDetalles(context, solicitud);
              },
              icon: const Icon(Icons.visibility, color: Colors.white),
              label: const Text(
                'Ver',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () async {
                await _descargarPDF(context, solicitud);
              },
              icon: const Icon(Icons.download, color: Colors.white),
              label: const Text(
                'Descargar',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verDetalles(
      BuildContext context, SolicitudMantenimiento solicitud) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Bordes redondeados
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Fondo blanco
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 2), // Sombra ligera
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Detalles de la Solicitud',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('Solicitante: ${solicitud.nombreSolicitante}',
                    style: const TextStyle(color: Colors.black)),
                Text('Departamento: ${solicitud.departamento}',
                    style: const TextStyle(color: Colors.black)),
                Text('Descripción: ${solicitud.descripcion}',
                    style: const TextStyle(color: Colors.black)),
                Text('Prioridad: ${solicitud.prioridad}',
                    style: const TextStyle(color: Colors.black)),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cerrar',
                        style: TextStyle(color: Colors.red)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _descargarPDF(
      BuildContext context, SolicitudMantenimiento solicitud) async {
    // Solicitar permisos de almacenamiento
    final status = await Permission.storage.request();

    if (status.isGranted) {
      // Generar el PDF
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child: pw.Text('Solicitud de Mantenimiento\n\n'
                'Solicitante: ${solicitud.nombreSolicitante}\n'
                'Departamento: ${solicitud.departamento}\n'
                'Descripción: ${solicitud.descripcion}\n'
                'Prioridad: ${solicitud.prioridad}'),
          ),
        ),
      );

      try {
        // Obtén el directorio de descargas
        final directory = await getExternalStorageDirectory();
        final filePath =
            '${directory!.path}/solicitud_mantenimiento_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final file = File(filePath);
        await file.writeAsBytes(await pdf.save());

        // Mostrar SnackBar si el PDF se guardó correctamente
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF guardado en $filePath'),
            backgroundColor: Colors.green,
          ),
        );

        // Espera un poco antes de abrir el menú de compartir para asegurar que el archivo esté accesible
        await Future.delayed(const Duration(milliseconds: 500));

        // Compartir el archivo PDF
        Share.shareFiles([filePath], text: 'Aquí está el PDF solicitado');
      } catch (e) {
        // Mensaje de error en caso de fallo
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar o compartir PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Mensaje si el permiso fue denegado o está permanentemente denegado
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permiso de almacenamiento denegado.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }
}
