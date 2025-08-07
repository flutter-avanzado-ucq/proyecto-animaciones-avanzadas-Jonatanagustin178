import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/tarea_screen.dart';
import 'tema/tema_app.dart';
import 'providers/weather_provider.dart';
import 'providers/holiday_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
        ChangeNotifierProvider(create: (context) => HolidayProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tareas Pro',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const TaskScreen(),
      ),
    );
  }
}
