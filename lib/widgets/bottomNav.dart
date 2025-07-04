import 'package:deepdo/utils/colors.dart';
import 'package:flutter/material.dart';
import '../screens/aiChat/chatScreen.dart';
import '../screens/room/coWorkingScreen.dart';
import '../screens/home/homeScreen.dart';
import '../screens/social/socialScreen.dart';

class MainWrapper extends StatefulWidget {
  final int selectedIndex;
  MainWrapper(this.selectedIndex);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late int _selectedIndex;

  // List of widgets (screens) to display based on the selected tab
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreenContent(), // This will be your original HomeScreen's body content
    AiAssistantScreen(),
    CoWorkingRoomsScreen(),
    SocialGamificationScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // In this setup, direct navigation using pushNamed is less common for tabs.
    // Instead, you update the _selectedIndex, and the body of the Scaffold
    // automatically rebuilds with the correct widget from _widgetOptions.
    // If you need specific navigation *within* a tab, that would happen inside
    // the respective widget (e.g., AiAssistantScreen).
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions
            .elementAt(_selectedIndex), // Display the selected screen
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Rooms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.military_tech),
            label: 'Social',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: appColor.mainColor,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // To show all labels
      ),
    );
  }
}
