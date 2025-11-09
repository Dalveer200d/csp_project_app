// lib/screens/home_screen.dart
import 'package:csp_project_app/components/location_container.dart';
// FIX: Corrected typo in import
import 'package:csp_project_app/components/municipal_timing.dart';
import 'package:csp_project_app/components/quality_card.dart';
import 'package:csp_project_app/data/location_data_provider.dart';
import 'package:csp_project_app/components/add_quality_form.dart';
// NEW: Import the new repair dialog
import 'package:csp_project_app/components/add_repair_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // --- Method to show the 'Add' options ---
  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.water_drop),
                title: const Text('Add Water Quality Metrics'),
                onTap: () {
                  Navigator.pop(ctx); // Close the bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddQualityForm(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.timer),
                title: const Text('Add Municipal Water Timing'),
                onTap: () {
                  Navigator.pop(ctx); // Close the bottom sheet
                  _showTimingPicker(context); // Show the time picker dialog
                },
              ),
              // --- NEW: Add Repair Option ---
              ListTile(
                leading: const Icon(Icons.construction),
                title: const Text('Add Upcoming Repair'),
                onTap: () {
                  Navigator.pop(ctx); // Close the bottom sheet
                  _showAddRepairDialog(context); // Show the new dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // --- NEW: Method to show the Add Repair Dialog ---
  void _showAddRepairDialog(BuildContext context) {
    // Check if location is selected BEFORE showing the dialog
    final provider = context.read<LocationDataProvider>();
    if (provider.currentLocationName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a location on the Home tab first."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    showDialog(context: context, builder: (ctx) => const AddRepairDialog());
  }

  // --- Method to show the time pickers ---
  void _showTimingPicker(BuildContext context) async {
    // Check if location is selected BEFORE showing the dialog
    final provider = context.read<LocationDataProvider>();
    if (provider.currentLocationName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a location on the Home tab first."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Get start time
    final TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: "Select Start Time",
    );

    if (startTime == null) return; // User cancelled

    // Get end time
    final TimeOfDay? endTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: "Select End Time",
    );

    if (endTime == null) return; // User cancelled

    // If we have both, update the provider
    context.read<LocationDataProvider>().updateMunicipalTiming(
      startTime.format(context),
      endTime.format(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ... (Your background image Container is fine) ...
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://i.pinimg.com/736x/fc/fb/3a/fcfb3ac67cba18383af8d5604a09db3d.jpg",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          // We use a Consumer here to get the provider state
          Consumer<LocationDataProvider>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      const LocationContainer(),
                      const SizedBox(height: 10),

                      // Show loading spinner
                      if (provider.isLoading)
                        const Center(child: CircularProgressIndicator()),

                      // Show "No Data" message
                      if (!provider.isLoading &&
                          !provider.locationHasData &&
                          provider.currentLocationName != null)
                        Container(
                          // ... (Your 'No Data' container is fine) ...
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(211, 211, 211, 0.8),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            "No data available for this location. Be the first to add data using the '+' button!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),

                      // Show the data if it exists
                      if (!provider.isLoading && provider.locationHasData) ...[
                        QualityCard(
                          qualityMetrics: provider.locationData.qualityMetrics,
                        ),
                        // FIX: Corrected typo in widget name
                        MunicipalTiming(
                          start: provider.locationData.municipalStartTime,
                          end: provider.locationData.municipalEndTime,
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddOptions(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
