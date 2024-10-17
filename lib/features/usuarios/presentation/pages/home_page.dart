import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/login_viewmodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Lista de páginas para mostrar según el índice seleccionado
  final List<Widget> _pages = [
    Center(child: Text('Mantenimiento', style: TextStyle(fontSize: 24))),
    Center(child: Text('Reportes', style: TextStyle(fontSize: 24))),
    Center(child: Text('Equipos', style: TextStyle(fontSize: 24))),
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
    final user = loginViewModel.loggedInUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.account_circle, size: 30, color: Colors.white),
                // Ícono de usuario
                SizedBox(width: 10),
                // Espaciado entre ícono y texto
                Text(
                  loginViewModel.email,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white, size: 30),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.red,
        // Color de fondo del BottomNavigationBar
        selectedItemColor: Colors.white,
        // Color del ítem seleccionado
        unselectedItemColor: Colors.white70,
        // Color de los ítems no seleccionados
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.article), // Ícono para Mantenimiento
            label: 'Mantenimiento',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt), // Ícono para Reportes
            label: 'Reportes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.computer), // Ícono para Equipos
            label: 'Equipos',
          ),
        ],
      ),
    );
  }
}
