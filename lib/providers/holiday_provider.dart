import 'package:flutter/material.dart';
import '../services/holiday_service.dart';
import '../models/holiday.dart';

class HolidayProvider extends ChangeNotifier {
  final HolidayService _holidayService = HolidayService();

  List<Holiday> _holidays = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Holiday> get holidays => _holidays;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Feriados fijos de México
  final List<Map<String, dynamic>> _mexicanHolidays = [
    {'month': 1, 'day': 1, 'localName': 'Año Nuevo', 'name': 'New Year\'s Day'},
    {
      'month': 2,
      'day': 5,
      'localName': 'Día de la Constitución',
      'name': 'Constitution Day',
    },
    {
      'month': 3,
      'day': 21,
      'localName': 'Natalicio de Benito Juárez',
      'name': 'Benito Juarez Birthday',
    },
    {'month': 5, 'day': 1, 'localName': 'Día del Trabajo', 'name': 'Labor Day'},
    {
      'month': 9,
      'day': 16,
      'localName': 'Día de la Independencia',
      'name': 'Independence Day',
    },
    {
      'month': 11,
      'day': 20,
      'localName': 'Día de la Revolución',
      'name': 'Revolution Day',
    },
    {'month': 12, 'day': 25, 'localName': 'Navidad', 'name': 'Christmas Day'},
  ];

  Future<void> loadHolidays({
    required int year,
    required String countryCode,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Intenta cargar desde la API
      final holidays = await _holidayService.fetchHolidays(
        year: year,
        countryCode: countryCode,
      );
      _holidays = holidays;
    } catch (e) {
      // Si falla la API, usa los feriados locales para México
      if (countryCode.toUpperCase() == 'MX') {
        _holidays =
            _mexicanHolidays.map((holiday) {
              return Holiday(
                date: DateTime(year, holiday['month'], holiday['day']),
                localName: holiday['localName'],
                name: holiday['name'],
                countryCode: 'MX',
                fixed: true,
                global: true,
              );
            }).toList();
      } else {
        _errorMessage = 'No se pudieron cargar los feriados';
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  bool isHoliday(DateTime date) {
    // Verifica feriados fijos de México
    for (var holiday in _mexicanHolidays) {
      if (date.month == holiday['month'] && date.day == holiday['day']) {
        return true;
      }
    }

    // Verifica feriados cargados desde la API
    return _holidays.any(
      (holiday) =>
          holiday.date.year == date.year &&
          holiday.date.month == date.month &&
          holiday.date.day == date.day,
    );
  }

  Holiday? getHoliday(DateTime date) {
    // Verifica feriados fijos de México primero
    for (var holiday in _mexicanHolidays) {
      if (date.month == holiday['month'] && date.day == holiday['day']) {
        return Holiday(
          date: DateTime(date.year, holiday['month'], holiday['day']),
          localName: holiday['localName'],
          name: holiday['name'],
          countryCode: 'MX',
          fixed: true,
          global: true,
        );
      }
    }

    // Si no es un feriado fijo, busca en los cargados desde la API
    try {
      return _holidays.firstWhere(
        (holiday) =>
            holiday.date.year == date.year &&
            holiday.date.month == date.month &&
            holiday.date.day == date.day,
      );
    } catch (e) {
      return null;
    }
  }
}
