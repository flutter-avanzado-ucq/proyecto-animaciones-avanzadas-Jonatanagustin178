import 'package:flutter/material.dart';

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
      child: Row(
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
    );
  }
}
