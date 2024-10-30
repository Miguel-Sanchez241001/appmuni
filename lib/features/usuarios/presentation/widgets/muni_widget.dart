import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:appmuni/theme/colors.dart';

class MunicipalInfoWidget extends StatelessWidget {
  const MunicipalInfoWidget({super.key});

  // URL de la municipalidad
  final String urlMunicipalidad = 'https://www.muniasia.gob.pe/';

  // Método para abrir la URL
  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(urlMunicipalidad);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,
          mode: LaunchMode.externalApplication); // Usa `externalApplication`
    } else {
      throw 'No se pudo abrir el sitio: $urlMunicipalidad';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo de la Municipalidad
          Image.asset('assets/images/logo.png', height: 150),
          const SizedBox(height: 20),

          // Título de bienvenida
          const Text(
            'Bienvenidos a la Municipalidad de Asia, Perú',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 10),

          // Resumen descriptivo de la municipalidad
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'La Municipalidad de Asia, ubicada en la región costera del Perú, '
              'es una entidad comprometida con el desarrollo, el bienestar de sus habitantes y la promoción cultural. '
              'Visita nuestro sitio para conocer más sobre nuestros proyectos y servicios.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Botón que abre el navegador al sitio web de la municipalidad
          ElevatedButton(
            onPressed: _launchURL,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            child: const Text(
              'Visita nuestra web',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
