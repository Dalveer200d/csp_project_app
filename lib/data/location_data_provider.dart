// lib/data/location_data_provider.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csp_project_app/data/review.dart';
import 'package:csp_project_app/data/repair.dart';

// ... LocationData class remains the same ...
class LocationData {
  String locationName;
  Map<String, String> qualityMetrics;
  String municipalStartTime;
  String municipalEndTime;

  LocationData({
    this.locationName = "Select a Location",
    Map<String, String>? qualityMetrics,
    this.municipalStartTime = "N/A",
    this.municipalEndTime = "N/A",
  }) : qualityMetrics =
           qualityMetrics ?? // Default empty values
           {
             'pH': '0.0',
             'DO': '0.0',
             'BOD': '0.0',
             'Turbidity': '0.0',
             'Nitrate': '0.0',
             'Ecoli': '0.0',
           };

  // Factory to create LocationData from a Firestore map
  factory LocationData.fromMap(Map<String, dynamic> map) {
    return LocationData(
      locationName: map['locationName'] ?? 'Unknown Location',
      qualityMetrics: Map<String, String>.from(map['qualityMetrics'] ?? {}),
      municipalStartTime: map['municipalStartTime'] ?? 'N/A',
      municipalEndTime: map['municipalEndTime'] ?? 'N/A',
    );
  }

  // Method to convert LocationData to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'locationName': locationName,
      'qualityMetrics': qualityMetrics,
      'municipalStartTime': municipalStartTime,
      'municipalEndTime': municipalEndTime,
    };
  }
}

/// 2. The Provider (ChangeNotifier)
class LocationDataProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Private State
  String? _currentLocationName;
  LocationData _locationData = LocationData();
  List<Review> _reviews = [];
  List<Repair> _repairs = [];
  bool _isLoading = false;
  bool _locationHasData = false;

  // Stream listeners
  StreamSubscription? _docListener;
  StreamSubscription? _reviewsListener;
  StreamSubscription? _repairsListener;

  // --- NEW: Constructor to set a default location ---
  LocationDataProvider() {
    // This will load the app with a default location
    // and prevent 'null' errors on startup.
    updateLocation("Guntur");
  }

  // Getters for the UI
  String? get currentLocationName => _currentLocationName;
  LocationData get locationData => _locationData;
  List<Review> get reviews => _reviews;
  List<Repair> get repairs => _repairs;
  bool get isLoading => _isLoading;
  bool get locationHasData => _locationHasData;

  // Main method to change location
  void updateLocation(String newLocation) {
    if (newLocation == _currentLocationName) return;

    _isLoading = true;
    _currentLocationName = newLocation;
    notifyListeners();

    // Cancel all old listeners to prevent memory leaks
    _docListener?.cancel();
    _reviewsListener?.cancel();
    _repairsListener?.cancel();

    // Get the reference to the location document
    final docRef = _db.collection('locations').doc(_currentLocationName!);

    // 1. Listen to the main location document
    _docListener = docRef.snapshots().listen((doc) {
      if (doc.exists && doc.data() != null) {
        _locationData = LocationData.fromMap(doc.data()!);
        _locationHasData = true;
      } else {
        _locationData = LocationData(locationName: newLocation);
        _locationHasData = false;
      }
      _isLoading = false;
      notifyListeners();
    });

    // 2. Listen to the 'reviews' subcollection
    _reviewsListener = docRef.collection('reviews').snapshots().listen((
      snapshot,
    ) {
      _reviews = snapshot.docs
          .map((doc) => Review.fromMap(doc.data()))
          .toList();
      notifyListeners();
    });

    // 3. Listen to the 'repairs' subcollection
    _repairsListener = docRef.collection('repairs').snapshots().listen((
      snapshot,
    ) {
      _repairs = snapshot.docs
          .map((doc) => Repair.fromMap(doc.data()))
          .toList();
      notifyListeners();
    });
  }

  // --- Methods to WRITE data to Firebase ---

  Future<void> updateQualityMetrics(Map<String, String> newMetrics) async {
    if (_currentLocationName == null) return;
    final docRef = _db.collection('locations').doc(_currentLocationName!);
    _locationData.qualityMetrics = newMetrics;
    await docRef.set(_locationData.toMap(), SetOptions(merge: true));
  }

  Future<void> updateMunicipalTiming(String startTime, String endTime) async {
    if (_currentLocationName == null) return;
    final docRef = _db.collection('locations').doc(_currentLocationName!);
    _locationData.municipalStartTime = startTime;
    _locationData.municipalEndTime = endTime;
    await docRef.set(_locationData.toMap(), SetOptions(merge: true));
  }

  Future<void> addReview(Review review) async {
    if (_currentLocationName == null) return;
    final collectionRef = _db
        .collection('locations')
        .doc(_currentLocationName!)
        .collection('reviews');
    await collectionRef.add(review.toMap());
  }

  // --- NEW: Method to add a repair ---
  Future<void> addRepair(Repair repair) async {
    if (_currentLocationName == null) return;
    final collectionRef = _db
        .collection('locations')
        .doc(_currentLocationName!)
        .collection('repairs');
    await collectionRef.add(repair.toMap());
  }
}
