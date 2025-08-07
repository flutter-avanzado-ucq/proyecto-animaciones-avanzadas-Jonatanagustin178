import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
// Importo los widgets y providers que voy a probar
import '../../lib/widgets/header.dart';
import '../../lib/providers/holiday_provider.dart';
import '../../lib/models/holiday.dart'; // Importo la clase Holiday

// Clase para bloquear todas las peticiones HTTP en los tests
class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // Lanzo una excepción para evitar cualquier petición HTTP
    throw const SocketException('No internet during testing');
  }
}

// Clase falsa para simular el provider de feriados sin hacer llamadas de red
class MockHolidayProvider extends HolidayProvider {
  // Sobrescribo todas las propiedades para evitar problemas
  @override
  bool get isLoading => false;

  @override
  String? get errorMessage => null;

  @override
  List<Holiday> get holidays => [];

  // Sobrescribo el método para evitar llamadas de red reales
  @override
  Future<void> loadHolidays({
    required int year,
    required String countryCode,
  }) async {
    // No hago nada para evitar llamadas de red en el test
    return;
  }

  // Simulo que no hay feriado hoy para simplificar el test
  @override
  bool isHoliday(DateTime date) {
    return false; // Retorno false para evitar mostrar información de feriados
  }

  // Simulo que no hay información de feriado
  @override
  Holiday? getHoliday(DateTime date) {
    return null; // Retorno null para indicar que no hay feriado
  }
}

void main() {
  // Configuración inicial para bloquear peticiones HTTP
  setUpAll(() {
    HttpOverrides.global = TestHttpOverrides();
  });

  // Restauro el estado después de los tests
  tearDownAll(() {
    HttpOverrides.global = null;
  });

  // Test principal para verificar que mi widget Header se construye correctamente
  testWidgets('Header se construye y muestra información básica', (
    WidgetTester tester,
  ) async {
    // Construyo el entorno de prueba con un provider simulado
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<HolidayProvider>(
          // Uso mi provider simulado para evitar llamadas de red
          create: (context) => MockHolidayProvider(),
          builder: (context, child) {
            return Scaffold(
              body: const Header(
                // Le paso el número de tareas pendientes requerido
                pendingTasks: 3,
                // Le paso el modo oscuro como falso
                isDarkMode: false,
              ),
            );
          },
        ),
      ),
    );

    // Solo hago pump una vez para evitar problemas de red
    await tester.pump();

    // Verifico que el widget Header se haya construido correctamente
    expect(find.byType(Header), findsOneWidget);

    // Verifico que aparezca el saludo
    expect(find.textContaining('Hola'), findsOneWidget);

    // Verifico que aparezca información de tareas pendientes
    expect(find.textContaining('Tareas pendientes'), findsOneWidget);

    // Verifico que aparezca el número específico de tareas
    expect(find.textContaining('3'), findsOneWidget);
  });

  // Test adicional para verificar modo oscuro
  testWidgets('Header funciona en modo oscuro', (WidgetTester tester) async {
    // Construyo el widget con modo oscuro activado
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<HolidayProvider>(
          create: (context) => MockHolidayProvider(),
          builder: (context, child) {
            return const Scaffold(
              body: Header(
                pendingTasks: 5,
                isDarkMode: true, // Activo el modo oscuro
              ),
            );
          },
        ),
      ),
    );

    // Solo hago pump básico
    await tester.pump();

    // Verifico que el widget se construyó correctamente
    expect(find.byType(Header), findsOneWidget);

    // Verifico que muestra el número correcto de tareas
    expect(find.textContaining('5'), findsOneWidget);
  });
}
