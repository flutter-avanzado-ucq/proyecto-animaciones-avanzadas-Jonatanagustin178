import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/holiday_provider.dart';

class Header extends StatelessWidget {
  final int pendingTasks;
  final bool isDarkMode;

  const Header({
    super.key,
    required this.pendingTasks,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final holidayProvider = Provider.of<HolidayProvider>(context);
    final today = DateTime.now();
    final isHolidayToday = holidayProvider.isHoliday(today);
    final todayHoliday = holidayProvider.getHoliday(today);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              isDarkMode
                  ? [Colors.deepPurple.shade900, Colors.deepPurple.shade700]
                  : const [Color(0xFF7F00FF), Color(0xFFE100FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/8/8a/Banana-Single.jpg',
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hola, Jonatan 👋',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'Tareas pendientes: $pendingTasks',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          if (isHolidayToday && todayHoliday != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '🎉 Hoy es feriado: ${todayHoliday.localName}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
