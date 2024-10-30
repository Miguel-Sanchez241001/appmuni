import 'dart:io';
import 'package:appmuni/features/mantenimientos/presentation/viewmodels/busquedasolicitudes_viewmodel.dart';
import 'package:appmuni/theme/colors.dart';
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
              Text(
                'Registro de mantenimiento',
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                label: 'Nombre del Area',
                onChanged: (value) => viewModel.setNombreBuscado(value),
              ),
              _buildTextField(
                label: 'Sede',
                onChanged: (value) => viewModel.setDepartamentoBuscado(value),
              ),
              _buildDropdown(
                label: 'CPU (MARCA - MODELO) ',
                items: [
                  'VASTEC COMMANDER G8',
                  'HP ELITEDESK 600 G1',
                  'HP ELITEDESK 800 G1',
                  'HP PRODESK 400 G5',
                  'HP PRODESK 400 G6',
                  'HP PRODESK 400 G7',
                  'HP PRODESK 600 G4',
                  'HP PRODESK 600 G5',
                  'ANTRYX',
                  'RHINOBOX KEROS SFF 5010',
                  'ADVANCE VO1087',
                ],
                value: viewModel.marca,
                onChanged: (value) => viewModel.setMarca(value!),
              ),
              _buildTextField(
                label: 'Numero de serie (CPU)',
                onChanged: (value) => viewModel.setNumeroSerie(value),
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                label: 'Monitor (MARCA - MODELO) ',
                items: [
                  'Seleccione',
                  'ADVANCE ADV-5023N',
                  'DELL E2216H',
                  'HP E233',
                  'LG 22MK600M',
                  'LG 24MK430H',
                  'LG 20M45A-B',
                  'LG 22MK430H-B',
                  'LG 22MK400H-B',
                  'SAMSUNG SR4C310EAL',
                  'SAMSUNG S24R35AFHN',
                  'SAMSUNG S22A33ANHL',
                  'SAMSUNG S20D300GNA',
                  'TEROS TE-3130',
                  'TEROS TE-24FHD8',
                ],
                value: viewModel.monitor,
                onChanged: (value) => viewModel.setMarca(value!),
              ),
              _buildTextField(
                label: 'Numero de serie (Monitor)',
                onChanged: (value) => viewModel.setNumeroSerie(value),
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                label: 'Teclado (MARCA) ',
                items: [
                  'Seleccione',
                  'LOGITECH',
                  'HP',
                  'GENIUS',
                  'MICROSOFT',
                  'COMPAQ',
                  'BENQ',
                  'HALION',
                  'DELL',
                  'XTECH',
                  'MAXELL',
                  'SEISA',
                  'MICRONICS',
                ],
                value: viewModel.teclado,
                onChanged: (value) => viewModel.setMarca(value!),
              ),
              _buildTextField(
                label: '(Modelo - Serie)',
                onChanged: (value) => viewModel.setNumeroSerie(value),
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
                  backgroundColor: AppColors.primary,
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
          labelStyle: const TextStyle(color: AppColors.primary),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
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
        Text(label, style: const TextStyle(color: AppColors.primary)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
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
                  fontWeight: FontWeight.bold, color: AppColors.primary),
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
                backgroundColor: AppColors.primary,
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
                backgroundColor: AppColors.primary,
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
                      color: AppColors.primary,
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
                        style: TextStyle(color: AppColors.primary)),
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
            backgroundColor: AppColors.primary,
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
