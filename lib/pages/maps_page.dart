import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  // Controller for the Google Map
  GoogleMapController? _mapController;

  // Controller for the search text field
  final TextEditingController _searchController = TextEditingController();

  // Initial camera position (San Francisco by default)
  static const LatLng _initialPosition = LatLng(37.7749, -122.4194);

  // Stores the currently selected position
  LatLng? _selectedPosition;

  // Stores the name of the selected place (city/town/village)
  String _selectedPlaceName = "No location selected";

  // Set of markers to display on the map
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // Try to get the current location when the widget loads
    _getCurrentLocation();
  }

  /// Called when the Google Map is created
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  /// Gets the user's current location and updates the map
  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showError("Location services are disabled.");
        return;
      }

      // Check for location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showError("Location permissions are denied.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showError("Location permissions are permanently denied.");
        return;
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final currentLatLng = LatLng(position.latitude, position.longitude);

      // Update the map and placemark
      _updateMapAndPlacemark(currentLatLng, zoom: 15.0);
    } catch (e) {
      _showError("Failed to get current location: $e");
    }
  }

  /// Handles map tap events
  void _onMapTap(LatLng position) {
    _updateMapAndPlacemark(position);
  }

  /// Handles search submission
  Future<void> _onSearchSubmitted(String query) async {
    if (query.isEmpty) return;

    try {
      // Use geocoding to find locations from the search query
      List<Location> locations = await locationFromAddress(query);

      if (locations.isNotEmpty) {
        final location = locations.first;
        final latLng = LatLng(location.latitude, location.longitude);
        // Update the map and placemark based on the search result
        _updateMapAndPlacemark(latLng, zoom: 12.0);
      } else {
        _showError("No locations found for '$query'");
      }
    } catch (e) {
      _showError("Failed to search for location: $e");
    }
  }

  /// Core function: Updates map, marker, and place name for a given LatLng
  Future<void> _updateMapAndPlacemark(LatLng position, {double? zoom}) async {
    String placeName = "Unknown location";

    try {
      // Perform reverse geocoding to get address details
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;

        // This is the key logic to get city, town, or village.
        // 'locality' is the most reliable field for this.
        // If 'locality' is empty, we fall back to 'subAdministrativeArea' (like a county)
        // or the 'administrativeArea' (like a state).
        placeName =
            placemark.locality ??
            placemark.subAdministrativeArea ??
            placemark.administrativeArea ??
            "Unknown area";
      }
    } catch (e) {
      placeName = "Could not get place name";
    }

    // Update the state with the new information
    setState(() {
      _selectedPosition = position;
      _selectedPlaceName = placeName;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId("selected_location"),
          position: _selectedPosition!,
          infoWindow: InfoWindow(
            title: _selectedPlaceName,
            snippet: "Tap to select",
          ),
        ),
      );
    });

    // Animate the map camera to the new position
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(position, zoom ?? 14.0),
    );
  }

  /// Helper to show a SnackBar error message
  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: Stack(
        children: [
          // The Google Map widget
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: _initialPosition,
              zoom: 11.0,
            ),
            markers: _markers,
            onTap: _onMapTap,
            mapType: MapType.normal,
          ),

          // Search Bar
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search for a city, town, or village...",
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _searchController.clear(),
                  ),
                ),
                onSubmitted: _onSearchSubmitted,
              ),
            ),
          ),

          // Selected Location Info Card
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Selected Location:",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _selectedPlaceName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    if (_selectedPosition != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        "Lat: ${_selectedPosition!.latitude.toStringAsFixed(4)}, Lng: ${_selectedPosition!.longitude.toStringAsFixed(4)}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                    // ADDED: A button to confirm the selection
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        // Only allow popping if a location is selected
                        if (_selectedPosition != null) {
                          // This is the key: pop with the selected name
                          Navigator.pop(context, _selectedPlaceName);
                        } else {
                          _showError(
                            "Please select a location on the map first.",
                          );
                        }
                      },
                      child: const Text("SELECT THIS LOCATION"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Floating Action Button to get current location
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }
}
