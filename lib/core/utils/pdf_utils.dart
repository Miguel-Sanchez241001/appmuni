import 'dart:io';
import 'package:appmuni/features/mantenimientos/presentation/viewmodels/busquedasolicitudes_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class PdfUtils {
  static Future<void> descargarYCompartirPDF(
      BuildContext context, SolicitudMantenimiento solicitud) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
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
        final directory = await getExternalStorageDirectory();
        final filePath =
            '${directory!.path}/solicitud_mantenimiento_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final file = File(filePath);
        await file.writeAsBytes(await pdf.save());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF guardado en $filePath'),
            backgroundColor: Colors.green,
          ),
        );

        await Future.delayed(const Duration(milliseconds: 500));

        Share.shareFiles([filePath], text: 'Aquí está el PDF solicitado');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar o compartir PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permiso de almacenamiento denegado.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }
}
