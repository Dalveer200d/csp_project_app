// lib/data/review.dart
class Review {
  final String name;
  final int rating;
  final String comment;
  final String date;

  Review({
    required this.name,
    required this.rating,
    required this.comment,
    required this.date,
  });

  // Factory to create a Review from a Firestore map
  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      name: map['name'] ?? '',
      rating: map['rating'] ?? 0,
      comment: map['comment'] ?? '',
      date: map['date'] ?? '',
    );
  }

  // Method to convert a Review instance to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rating': rating,
      'comment': comment,
      'date': date,
    };
  }
}