// lib/data/repair.dart
class Repair {
  final String title;
  final String description;
  final String date;
  final String status;

  Repair({
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });

  // Factory to create a Repair from a Firestore map
  factory Repair.fromMap(Map<String, dynamic> map) {
    return Repair(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      status: map['status'] ?? '',
    );
  }

  // Method to convert a Repair instance to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'status': status,
    };
  }
}