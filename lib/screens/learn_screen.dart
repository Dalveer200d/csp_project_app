import 'package:csp_project_app/pages/harvesting_page.dart';
import 'package:csp_project_app/pages/purification_page.dart';
import 'package:csp_project_app/pages/rivers_page.dart';
import 'package:flutter/material.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  List<Map<String, dynamic>> learnTopics = [
    {
      "title": "Rivers of India",
      "subtitle": "Learn about the rivers of our country.",
      "icon": Icons.waves,
      "url":
          "https://img.freepik.com/premium-vector/river-icon-logo-vector-design-template_827767-213.jpg",
    },
    {
      "title": "Harvesting",
      "subtitle":
          "Learn about various water harvesting and conservation techniques.",
      "icon": Icons.water_drop,
      "url":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS67OS2dlXk_sg-5sY1dG0Sd-Ky3djCtmfhtw&s",
    },
    {
      "title": "Water Purification",
      "subtitle": "Learn about various water purification methods",
      "icon": Icons.cleaning_services,
      "url":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSspoRd5cc4GM4smR_QbxIQ2NnEW9brXtVUGQ&s",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Image.network(
              "https://i.pinimg.com/736x/24/f4/36/24f4363519e59fabdd7d772d08b934bc.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 4,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: learnTopics.length,
              itemBuilder: (context, index) {
                final topic = learnTopics[index];
                return Card(
                  elevation: 4,
                  color: Colors.blueGrey.withAlpha(05),
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    onTap: () {
                      if (topic["title"] == "Rivers of India") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RiversPage()),
                        );
                      } else if (topic["title"] == "Harvesting") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HarvestingPage(),
                          ),
                        );
                      } else if (topic["title"] == "Water Purification") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PurificationPage(),
                          ),
                        );
                      }
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(topic['url']),
                    ),
                    title: Text(
                      topic["title"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(topic["subtitle"]),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
