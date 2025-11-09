import 'package:flutter/material.dart';

class QualityMetricIcon extends StatelessWidget {
  const QualityMetricIcon({super.key, required this.type, required this.value});

  final String type;
  final String value;

  static const Map<String, IconData> iconNames = {
    'pH': Icons.science,
    'DO': Icons.water_drop_outlined,
    'BOD': Icons.bubble_chart,
    'Turbidity': Icons.opacity,
    'Nitrate': Icons.eco,
    'Ecoli': Icons.coronavirus,
  };

  static const Map<String, Color> iconColors = {
    'pH': Colors.purple,
    'DO': Colors.blue,
    'BOD': Colors.orange,
    'Turbidity': Colors.teal,
    'Nitrate': Colors.green,
    'Ecoli': Colors.red,
  };

  static const Map<String, String> unitNames = {
    'pH': '',
    'DO': 'mg/L',
    'BOD': 'mg/L',
    'Turbidity': 'NTU',
    'Nitrate': 'mg/L',
    'Ecoli': '/100mL',
  };

  @override
  Widget build(BuildContext context) {
    final icon = iconNames[type] ?? Icons.help_outline;
    final color = iconColors[type] ?? Colors.grey;
    final unit = unitNames[type] ?? '';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 40, color: color),
        const SizedBox(height: 6),
        Text(
          type,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        Text(
          '$value $unit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: color,
          ),
        ),
      ],
    );
  }
}
