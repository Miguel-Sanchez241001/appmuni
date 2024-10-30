import 'package:appmuni/features/mantenimientos/presentation/widgets/estado_widget.dart';
import 'package:appmuni/features/usuarios/presentation/widgets/muni_widget.dart';
import 'package:appmuni/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mantenimientos/presentation/pages/mantenimiento_page.dart';
import '../viewmodels/login_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Lista de ítems del BottomNavigationBar
  final List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home), // Ícono para la pantalla inicial
      label: 'Inicio',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.article), // Ícono para Mantenimiento
      label: 'Funciones',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.receipt), // Ícono para Reportes
      label: 'Reportes',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.computer), // Ícono para Equipos
      label: 'Equipos',
    ),
  ];

  // Lista de páginas para mostrar según el índice seleccionado
  final List<Widget> _pages = [
    Center(child: MunicipalInfoWidget()),
    Center(child: MantenimientoPage()),
    const Center(child: EstadoWidget()),
    const Center(child: Text('Equipos', style: TextStyle(fontSize: 24))),
  ];

  // Método para cambiar de página
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.account_circle, size: 30, color: Colors.white),
                // Ícono de usuario
                const SizedBox(width: 10),
                // Espaciado entre ícono y texto
                Text(
                  loginViewModel.email,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            IconButton(
              icon:
                  const Icon(Icons.exit_to_app, color: Colors.white, size: 30),
              // Ícono de logout
              onPressed: () {
                loginViewModel.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      // Cambia de página según el ítem seleccionado
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        // Esto asegura que ocupe solo el espacio necesario
        children: [
          Container(
            height: 2,
            color: Colors.white, // Línea blanca separadora
          ),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            // Forzar modo "fixed"

            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: AppColors.primary,
            // Color de fondo del BottomNavigationBar
            selectedItemColor: Colors.white,
            // Color del ítem seleccionado
            unselectedItemColor: Colors.white70,
            // Color de los ítems no seleccionados
            items: bottomNavItems,
          ),
        ],
      ),
    );
  }
}
