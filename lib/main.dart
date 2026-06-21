import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/acervo_screen.dart';
import 'screens/clientes_screen.dart';
import 'screens/detalhe_cliente_screen.dart';
import 'screens/funcionarios_screen.dart';
import 'models/cliente.dart';

void main() {
  runApp(const SeboLinhasApp());
}

class SeboLinhasApp extends StatelessWidget {
  const SeboLinhasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeboLinhas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B35),
          primary: const Color(0xFFFF6B35),
          secondary: const Color(0xFF1A1A2E),
          surface: const Color(0xFFF8F4F0),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F4F0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A2E),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFF1A1A2E),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6B35),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/menu': (context) => const MenuScreen(),
        '/acervo': (context) => const AcervoScreen(),
        '/clientes': (context) => const ClientesScreen(),
        '/funcionarios': (context) => const FuncionariosScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detalhe_cliente') {
          final cliente = settings.arguments as Cliente;
          return MaterialPageRoute(
            builder: (context) => DetalheClienteScreen(cliente: cliente),
          );
        }
        return null;
      },
    );
  }
}
