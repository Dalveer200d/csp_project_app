// lib/components/location_container.dart
import 'package:csp_project_app/data/location_data_provider.dart';
import 'package:csp_project_app/pages/maps_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider

class LocationContainer extends StatelessWidget {
  const LocationContainer({super.key});

  // Helper method to navigate and get the result
  void _navigateToMapsPage(BuildContext context) async {
    // 1. Make the navigation 'await' a result
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapsPage()),
    );

    // 2. Check if we got a result back
    if (result != null && result is String) {
      // 3. CRITICAL: Update the PROVIDER, not local state
      // Use context.read inside an async gap
      context.read<LocationDataProvider>().updateLocation(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 4. WATCH the provider for changes
    final provider = context.watch<LocationDataProvider>();

    return GestureDetector(
      onTap: () => _navigateToMapsPage(context), // 5. Call our method
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.indigo, width: 1),
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(211, 211, 211, 0.8),
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on /*color: Colors.black*/),
            const SizedBox(width: 10),
            Text(
              // 6. Display the location from the PROVIDER
              provider.currentLocationName ?? "Tap to select a location",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}