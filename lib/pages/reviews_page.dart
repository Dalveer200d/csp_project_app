// lib/pages/reviews_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:csp_project_app/data/location_data_provider.dart';
import '../components/review_card.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Consume the provider to get the list of reviews
    return Consumer<LocationDataProvider>(
      builder: (context, provider, child) {
        // Show a message if no location is selected
        if (provider.currentLocationName == null) {
          return const Center(
            child: Text("Please select a location on the Home tab first."),
          );
        }

        // Show a loading indicator
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show a message if the list is empty
        if (provider.reviews.isEmpty) {
          return const Center(
            child: Text("No reviews for this location yet. Be the first!"),
          );
        }

        // Build the list
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: provider.reviews.length,
          itemBuilder: (context, index) =>
              ReviewCard(review: provider.reviews[index]),
        );
      },
    );
  }
}