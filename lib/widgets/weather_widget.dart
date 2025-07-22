// widgets/weather_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  @override
  void initState() {
    super.initState();
    // Cargar clima para Querétaro, México (coordenadas del centro de la ciudad)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().loadWeather(20.5888, -100.3899);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        if (weatherProvider.isLoading) {
          return const Card(
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  Text('Cargando clima...'),
                ],
              ),
            ),
          );
        }

        if (weatherProvider.errorMessage != null) {
          return Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      weatherProvider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (weatherProvider.weatherData != null) {
          final weather = weatherProvider.weatherData!;
          return Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.network(
                        'https://openweathermap.org/img/w/${weather.iconCode}.png',
                        width: 50,
                        height: 50,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.cloud, size: 50),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              weather.cityName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              '${weather.temperature.round()}°C',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              weather.description,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
