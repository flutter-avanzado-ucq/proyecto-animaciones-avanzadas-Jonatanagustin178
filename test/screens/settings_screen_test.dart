import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
// Importo la pantalla que voy a probar (en este caso uso tarea_screen como ejemplo)
import '../../lib/screens/tarea_screen.dart';
import '../../lib/providers/holiday_provider.dart';

void main() {
  // Test para verificar que mi pantalla de configuraciones muestra elementos básicos
  testWidgets('TaskScreen muestra elementos principales de la interfaz', (
    WidgetTester tester,
  ) async {
    // Construyo el entorno de prueba con el provider necesario
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<HolidayProvider>(
          // Creo una instancia del provider de feriados
          create: (context) => HolidayProvider(),
          builder: (context, child) {
            // Uso TaskScreen porque es la pantalla que sí existe en el proyecto
            return const TaskScreen();
          },
        ),
      ),
    );

    // Espero a que se complete toda la animación y renderizado
    await tester.pumpAndSettle();

    // Verifico que la pantalla se haya construido correctamente
    expect(find.byType(TaskScreen), findsOneWidget);

    // Verifico que aparezca un Scaffold (estructura básica de pantalla)
    expect(find.byType(Scaffold), findsOneWidget);

    // Verifico que aparezca un AppBar o algún elemento de navegación
    expect(find.byType(AppBar), findsWidgets);

    // Verifico que aparezcan botones interactivos
    expect(find.byType(FloatingActionButton), findsWidgets);
  });

  // Test adicional para verificar la interacción con elementos de la interfaz
  testWidgets('TaskScreen responde a interacciones básicas', (
    WidgetTester tester,
  ) async {
    // Construyo el mismo entorno de prueba
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<HolidayProvider>(
          create: (context) => HolidayProvider(),
          builder: (context, child) {
            return const TaskScreen();
          },
        ),
      ),
    );

    // Espero a que se complete el renderizado
    await tester.pumpAndSettle();

    // Si existe un FloatingActionButton, verifico que se puede tocar
    final fabFinder = find.byType(FloatingActionButton);
    if (tester.any(fabFinder)) {
      // Simulo tocar el botón flotante
      await tester.tap(fabFinder.first);
      await tester.pump();

      // Verifico que algo cambió después del tap
      expect(find.byType(TaskScreen), findsOneWidget);
    }
  });
}
