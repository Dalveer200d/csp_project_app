import 'package:csp_project_app/components/quality_metric_icon.dart';
import 'package:flutter/material.dart';

class QualityCard extends StatelessWidget {
  // 1. Expect a map of metrics
  final Map<String, String> qualityMetrics;

  const QualityCard({
    super.key,
    required this.qualityMetrics,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo, width: 1),
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(211, 211, 211, 0.8),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 70,
        runSpacing: 10,
        // 2. Build the icons dynamically from the map
        children: qualityMetrics.entries.map((entry) {
          return QualityMetricIcon(
            type: entry.key,
            value: entry.value,
          );
        }).toList(),
      ),
    );
  }
}