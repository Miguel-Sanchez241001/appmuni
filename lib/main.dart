import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'features/usuarios/presentation/pages/home_page.dart';
import 'features/usuarios/presentation/pages/login_page.dart';
import 'features/usuarios/presentation/viewmodels/login_viewmodel.dart';
import 'injection_container/auth_provider.dart';
import 'injection_container/blocs/login_bloc.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        BlocProvider(create: (_) => LoginBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Definimos las rutas aquí
      initialRoute: '/',
      routes: {
        '/': (context) => AuthWrapper(),
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    if (loginViewModel.isLoading) {
      return Center(child: CircularProgressIndicator()); // Indicador de carga
    } else if (loginViewModel.loggedInUser != null) {
      // Usuario autenticado, redirigir a HomePage
      return HomePage();
    } else {
      // No autenticado, mostrar LoginPage
      return LoginPage();
    }
  }
}
