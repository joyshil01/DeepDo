// ignore_for_file: dead_code, deprecated_member_use, file_names

import 'dart:io';
import 'package:deepdo/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/bottomNav.dart';
import '../room/coWorkRoomDetails.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({Key? key}) : super(key: key);

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  // You can still add helper methods here if they only build widgets for this screen.
  Widget _buildTaskItem(String task) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline,
              color: appColor.mainColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              task,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoWorkingRoomCard(
      String roomName, int participants, BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(right: 15),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.visibility,
                color: appColor.mainColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              roomName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: appColor.mainColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$participants active',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CoWorkingRoomDetailScreen(
                        roomId: '1', roomName: roomName),
                  ),
                ); // You might navigate to a detail screen for this room
                print('Joining $roomName');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor.mainColor,
                foregroundColor: Colors.white,
                minimumSize:
                    const Size.fromHeight(35), // Make button full width
              ),
              child: const Text('Join'),
            ),
          ],
        ),
      ),
    );
  }

  String? name;
  String? email;

  @override
  void initState() {
    loadUserInfo();
    super.initState();
  }

  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('user_name');
      email = prefs.getString('user_email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Hello, $name'),
          backgroundColor: appColor.mainColor,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: false, // Hide back button
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                Navigator.pushNamed(context, '/notifications');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Focus Timer Widget
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        'Focus Time',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: appColor.mainColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Placeholder for actual timer display
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: CircularProgressIndicator(
                              value: 0.75, // Example progress
                              strokeWidth: 10,
                              backgroundColor:
                                  appColor.mainColor.withOpacity(0.2),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                appColor.mainColor,
                              ),
                            ),
                          ),
                          const Text(
                            '25:00', // Example time
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: appColor.mainColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/focus_timer');
                            },
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Start Focus'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appColor.mainColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Add more controls like pause/stop if needed
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // AI Productivity Assistant Section
              Text(
                'Your Daily Plan',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]),
              ),
              const SizedBox(height: 15),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'AI Suggested Tasks:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: appColor.mainColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Placeholder for AI tasks
                      _buildTaskItem('Complete Flutter UI for DeepDo'),
                      _buildTaskItem('Review Backend API Documentation'),
                      _buildTaskItem('Prepare presentation for Monday'),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainWrapper(1),
                              ),
                            );
                          },
                          child: const Text(
                            'Chat with AI Assistant',
                            style: TextStyle(
                              color: appColor.TextButtonColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Virtual Co-Working Rooms Section
              Text(
                'Virtual Co-Working Rooms',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 180, // Height for horizontal scroll
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCoWorkingRoomCard(
                        'Study Zone', 15, context), // Pass context here
                    _buildCoWorkingRoomCard(
                        'Coding Focus', 8, context), // Pass context here
                    _buildCoWorkingRoomCard(
                        'Creative Sprint', 5, context), // Pass context here
                    // Add more room cards
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainWrapper(2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.group),
                  label: const Text('Explore All Rooms'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: appColor.mainColor,
                    side: const BorderSide(
                      color: appColor.mainColor,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
