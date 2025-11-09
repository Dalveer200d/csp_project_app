import 'package:csp_project_app/components/theme_icon.dart';
import 'package:csp_project_app/screens/community_screen.dart';
import 'package:csp_project_app/screens/home_screen.dart';
import 'package:csp_project_app/screens/learn_screen.dart';
import 'package:csp_project_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:csp_project_app/pages/chatbot_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  List<Widget> widgetList = [
    HomeScreen(),
    CommunityScreen(),
    LearnScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ThemeIcon(),
        title: Text(
          "HYDRO SENSE",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatbotScreen()),
              );
            },
            icon: Icon(Icons.support_agent_outlined),
          ),
        ],
        actionsPadding: EdgeInsets.all(10),
      ),
      body: IndexedStack(index: selectedIndex, children: widgetList),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) => {
          setState(() {
            selectedIndex = index;
          }),
        },
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: "Community"),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_sharp),
            label: "Learn",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
