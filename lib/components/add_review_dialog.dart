import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:csp_project_app/data/location_data_provider.dart';
import 'package:csp_project_app/data/review.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth

class AddReviewDialog extends StatefulWidget {
  const AddReviewDialog({super.key});

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  // Add a FormKey
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  int _rating = 0; // 0 means no rating selected

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
  
  void _submitReview() {
    final provider = context.read<LocationDataProvider>();
    
    // Get the current user
    final user = context.read<User?>();

    // Check if user is logged in
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must be logged in to leave a review.")),
      );
      return;
    }

    // Location check
    if (provider.currentLocationName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a location first.")),
      );
      return;
    }

    // Rating check
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a star rating (1-5)")),
      );
      return;
    }

    // Validate the form
    if (_formKey.currentState!.validate()) {
      // Create the new review
      final newReview = Review(
        // Use user's email
        name: user.email ?? "Anonymous User", // Use email, fallback to anonymous
        rating: _rating,
        comment: _commentController.text,
        date: DateFormat('MMM d, yyyy').format(DateTime.now()),
      );

      // Call the provider to add it
      provider.addReview(newReview);

      ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text("Review submitted!")),
      );

      Navigator.pop(context); // Close the dialog
    }
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Add Review",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: _formKey, // Add form key
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- COMPLETED CODE for Star Rating ---
              const Text(
                'Your Rating:',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    icon: Icon(
                      _rating > index ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 30,
                    ),
                  );
                }),
              ),
              // --- End of Star Rating ---
              const SizedBox(height: 12),
              TextFormField(
                controller: _commentController,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Your Review",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? "Review comment is required" : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _submitReview, // Call the submit function
          child: const Text("Submit"),
        ),
      ],
    );
  }
}