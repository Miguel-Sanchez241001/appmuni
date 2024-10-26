import 'package:appmuni/features/mantenimientos/presentation/viewmodels/formulario_viewmodel.dart';
import 'package:appmuni/features/usuarios/presentation/viewmodels/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'features/usuarios/presentation/pages/home_page.dart';
import 'features/usuarios/presentation/pages/login_page.dart';
import 'features/usuarios/presentation/viewmodels/login_viewmodel.dart';
import 'injection_container/blocs/login_bloc.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => FormularioViewModel()),
        BlocProvider(create: (_) => LoginBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/home': (context) =>const HomePage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    if (loginViewModel.isLoading) {
      return const Center(child: CircularProgressIndicator()); // Indicador de carga
    } else if (loginViewModel.loggedInUser != null) {
      // Usuario autenticado, redirigir a HomePage
      return const HomePage();
    } else {
      // No autenticado, mostrar LoginPage
      return const LoginPage();
    }
  }
}
