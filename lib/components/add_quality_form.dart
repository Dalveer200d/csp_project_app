import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:csp_project_app/data/location_data_provider.dart';

class AddQualityForm extends StatefulWidget {
  const AddQualityForm({super.key});

  @override
  State<AddQualityForm> createState() => _AddQualityFormState();
}

class _AddQualityFormState extends State<AddQualityForm> {
  // A map to hold the form text controllers
  final Map<String, TextEditingController> _controllers = {
    'pH': TextEditingController(),
    'DO': TextEditingController(),
    'BOD': TextEditingController(),
    'Turbidity': TextEditingController(),
    'Nitrate': TextEditingController(),
    'Ecoli': TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    // Pre-fill the form fields with current data from the provider
    final currentMetrics =
        Provider.of<LocationDataProvider>(context, listen: false)
            .locationData
            .qualityMetrics;
    _controllers.forEach((key, controller) {
      controller.text = currentMetrics[key] ?? '0.0';
    });
  }

  @override
  void dispose() {
    // Clean up controllers
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _submitData() {
    // Create a new map from the controller values
    final Map<String, String> newMetrics = {};
    _controllers.forEach((key, controller) {
      newMetrics[key] = controller.text.isNotEmpty ? controller.text : '0.0';
    });

    // Call the provider method to update the data
    Provider.of<LocationDataProvider>(context, listen: false)
        .updateQualityMetrics(newMetrics);

    // Go back to the home screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Water Quality Metrics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ..._controllers.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: entry.value,
                  decoration: InputDecoration(
                    labelText: entry.key,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Save Metrics'),
            )
          ],
        ),
      ),
    );
  }
}