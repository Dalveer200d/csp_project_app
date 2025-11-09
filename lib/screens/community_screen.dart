import 'package:csp_project_app/components/add_review_dialog.dart';
import 'package:csp_project_app/pages/reviews_page.dart';
import 'package:csp_project_app/pages/upcoming_repairs_page.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                margin: EdgeInsets.symmetric(vertical: 0),
                child: TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(Icons.reviews_outlined),
                      text: "User Reviews",
                    ),
                    Tab(
                      icon: Icon(Icons.construction),
                      text: "Upcoming Repairs",
                    ),
                  ],
                  splashBorderRadius: BorderRadius.circular(20),
                  dividerHeight: 1,
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [ReviewsPage(), UpcomingRepairsPage()],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => const AddReviewDialog(),
              );
            },
            child: Icon(Icons.rate_review),
          ),
        ),
      ),
    );
  }
}
