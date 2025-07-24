import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/holiday_provider.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final bool isDone;
  final DateTime? date;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Animation<double> iconRotation;

  const TaskCard({
    super.key,
    required this.title,
    required this.isDone,
    this.date,
    required this.onToggle,
    required this.onDelete,
    required this.iconRotation,
  });

  @override
  Widget build(BuildContext context) {
    final holidayProvider = Provider.of<HolidayProvider>(context);
    final isHoliday = date != null ? holidayProvider.isHoliday(date!) : false;
    final holiday = date != null ? holidayProvider.getHoliday(date!) : null;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: isDone ? 0.6 : 1.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDone ? Colors.green.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: onToggle,
                child: AnimatedBuilder(
                  animation: iconRotation,
                  builder: (context, child) {
                    // El ángulo gira 180 grados (pi)
                    final angle = isDone ? iconRotation.value * pi : 0.0;
                    return Transform.rotate(
                      angle: angle,
                      child: Icon(
                        isDone
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: isDone ? Colors.green : Colors.grey,
                        size: 28,
                      ),
                    );
                  },
                ),
              ),
              title: Text(
                title,
                style: TextStyle(
                  decoration: isDone ? TextDecoration.lineThrough : null,
                  fontSize: 16,
                  color: isDone ? Colors.grey : Colors.black87,
                ),
              ),
              subtitle:
                  date != null
                      ? Text(
                        'Fecha: ${DateFormat('dd/MM/yyyy').format(date!)}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      )
                      : null,
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: onDelete,
              ),
            ),
            if (isHoliday && holiday != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: Text(
                  '🎉 Feriado: ${holiday.localName}',
                  style: TextStyle(
                    color: Colors.orange.shade800,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
