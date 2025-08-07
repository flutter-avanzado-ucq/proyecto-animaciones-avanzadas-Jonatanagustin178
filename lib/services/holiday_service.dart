import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/holiday.dart';

class HolidayService {
  static const String _baseUrl = 'https://date.nager.at/api/v3/PublicHolidays';

  Future<List<Holiday>> fetchHolidays({
    required int year,
    required String countryCode,
  }) async {
    final url = Uri.parse('$_baseUrl/$year/$countryCode');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Holiday.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los feriados: ${response.statusCode}');
    }
  }
}
