# 🚀 Guía de Comandos - Testing Flutter

## 📋 Comandos Principales

### Verificar Estado del Proyecto
```bash
# Verificar instalación de Flutter
flutter doctor

# Verificar dependencias
flutter pub get

# Analizar código
flutter analyze
```

### Ejecutar Tests - Todos los Funcionales
```bash
flutter test test/widgets/card_tarea_test.dart test/widgets/header_test_simple.dart test/screens/simple_task_screen_test.dart
```

### Ejecutar Tests Individuales
```bash
# Test 1: TaskCard (Widget con animaciones)
flutter test test/widgets/card_tarea_test.dart

# Test 2: Header Simplificado (Provider integration)
flutter test test/widgets/header_test_simple.dart

# Test 3: TaskScreen Simplificado (Screen testing)
flutter test test/screens/simple_task_screen_test.dart
```

### Tests con Detalles Verbose
```bash
# Para ver información detallada de los tests
flutter test --verbose test/widgets/card_tarea_test.dart test/widgets/header_test_simple.dart test/screens/simple_task_screen_test.dart
```

### Generar Reporte de Cobertura
```bash
# Generar cobertura de código (si está configurado)
flutter test --coverage
```

## 📊 Resultados Esperados

### Ejecución Exitosa - Todos los Tests
```
00:00 +0: Loading...
00:01 +0: TaskCard muestra título y responde a interacción
00:02 +1: Header simplificado se construye y muestra información  
00:02 +2: Header funciona en modo oscuro
00:02 +3: Header integra correctamente con HolidayProvider
00:03 +4: TaskScreen simplificado muestra elementos principales
00:03 +5: TaskScreen tiene la estructura correcta
00:03 +6: TaskScreen permite interacciones básicas
00:03 +7: TaskScreen se mantiene estable durante el uso
00:04 +8: All tests passed! ✅
```

### Ejecución Individual - TaskCard
```
00:03 +1: All tests passed! ✅
```

### Ejecución Individual - Header
```
00:02 +3: All tests passed! ✅
```

### Ejecución Individual - TaskScreen
```
00:02 +4: All tests passed! ✅
```

## 🐛 Solución de Problemas

### Si hay errores de dependencias:
```bash
flutter clean
flutter pub get
```

### Si hay problemas de versión:
```bash
flutter doctor
flutter upgrade
```

### Para debugging de tests:
```bash
flutter test --debug test/widgets/card_tarea_test.dart
```

## 📂 Archivos de Test Relevantes

- `test/widgets/card_tarea_test.dart` - Widget testing con animaciones
- `test/widgets/header_test_simple.dart` - Provider integration testing  
- `test/screens/simple_task_screen_test.dart` - Screen testing completo

## 🎯 Verificación Rápida

Para verificar que todo esté funcionando correctamente:

1. Ejecuta: `flutter doctor`
2. Ejecuta: `flutter pub get`  
3. Ejecuta: `flutter test test/widgets/card_tarea_test.dart test/widgets/header_test_simple.dart test/screens/simple_task_screen_test.dart`
4. Deberías ver: `All tests passed! ✅`

---
**Última actualización:** Agosto 7, 2025
