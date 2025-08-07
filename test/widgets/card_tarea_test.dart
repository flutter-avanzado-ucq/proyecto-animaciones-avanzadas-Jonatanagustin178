// Imports necesarios para el testing de widgets en Flutter
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // Para el TickerProvider
import 'package:flutter_test/flutter_test.dart'; // Framework de testing de Flutter
import 'package:provider/provider.dart'; // Para el manejo de estado
// Importo los archivos de mi proyecto que voy a probar
import '../../lib/widgets/card_tarea.dart';
import '../../lib/providers/holiday_provider.dart';

void main() {
  // Test para verificar que mi widget TaskCard funciona bien
  testWidgets('TaskCard muestra título y responde a interacción', (
    WidgetTester tester, // Herramienta para interactuar con widgets en el test
  ) async {
    // Mi variable para verificar si el botón funcionó
    bool wasToggled = false;

    // Necesito esto para la animación del ícono
    // AnimationController controla las animaciones del widget
    final AnimationController controller = AnimationController(
      vsync: TestVSync(), // Proveedor de ticks para la animación
      duration: const Duration(milliseconds: 300), // Duración de la animación
    );

    // Creo el entorno donde voy a probar mi widget
    // pumpWidget construye el árbol de widgets para el test
    await tester.pumpWidget(
      MaterialApp(
        // Necesario para que el widget tenga contexto de Material Design
        home: ChangeNotifierProvider<HolidayProvider>(
          // Provider para manejar estado de feriados
          create:
              (context) => HolidayProvider(), // Creo una instancia del provider
          builder: (context, child) {
            return Scaffold(
              // Estructura básica de pantalla
              body: TaskCard(
                // El widget que estoy probando
                title: 'Tarea de prueba', // Título que debe aparecer
                isDone: false, // Estado inicial: tarea no completada
                date: DateTime.now(), // Fecha actual para la tarea
                onToggle: () {
                  // Función que se ejecuta cuando se toca el ícono
                  wasToggled = true; // Cambio mi variable de control
                },
                onDelete:
                    () {}, // Función vacía para eliminar (no la uso en este test)
                iconRotation: controller, // Controlador de animación del ícono
              ),
            );
          },
        ),
      ),
    );

    // Verifico que aparezca el texto que puse
    // find.text busca un widget de texto específico
    // findsOneWidget confirma que encuentra exactamente uno
    expect(find.text('Tarea de prueba'), findsOneWidget);

    // Verifico que aparezca el ícono de tarea sin completar
    // find.byIcon busca un ícono específico
    expect(find.byIcon(Icons.radio_button_unchecked), findsOneWidget);

    // Simulo que el usuario toca el ícono
    // tap simula un toque en el widget encontrado
    await tester.tap(find.byIcon(Icons.radio_button_unchecked));
    // pump actualiza el árbol de widgets después de la interacción
    await tester.pump();

    // Verifico que sí se ejecutó mi función
    // isTrue confirma que la variable cambió a verdadero
    expect(wasToggled, isTrue);

    // Limpio la memoria
    // dispose libera los recursos del controlador de animación
    controller.dispose();
  });
}

// Clase que necesito para las animaciones en el test
// TestVSync simula el proveedor de ticks para animaciones
class TestVSync extends TickerProvider {
  @override
  // createTicker crea un objeto Ticker para controlar animaciones
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick); // Retorna un nuevo Ticker con la función callback
  }
}
