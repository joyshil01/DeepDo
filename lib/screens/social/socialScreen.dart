// ignore_for_file: deprecated_member_use, dead_code, file_names

import 'dart:io';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class SocialGamificationScreen extends StatelessWidget {
  const SocialGamificationScreen({Key? key}) : super(key: key);

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
          title: const Text('Social & Gamification'),
          automaticallyImplyLeading: false, // Hide back button
          backgroundColor: appColor.mainColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Streaks & XP',
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.local_fire_department,
                              color: Colors.orange[700], size: 40),
                          const SizedBox(height: 8),
                          const Text('Daily Streak',
                              style: TextStyle(fontSize: 16)),
                          const Text('🔥 7 Days',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.star, color: Colors.amber[700], size: 40),
                          const SizedBox(height: 8),
                          const Text('Total XP',
                              style: TextStyle(fontSize: 16)),
                          const Text('✨ 1500 XP',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Leaderboards',
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
                child: ListView.builder(
                  shrinkWrap: true, // Important for nested ListView
                  physics:
                      const NeverScrollableScrollPhysics(), // Important for nested ListView
                  itemCount: 5, // Example top 5 users
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: appColor.mainColor[100],
                        child: Text('${index + 1}',
                            style: TextStyle(color: Colors.blue[900])),
                      ),
                      title: Text('User Name ${index + 1}'),
                      subtitle: Text('${(1000 - index * 100)} XP'),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          size: 16, color: appColor.mainColor),
                      onTap: () {
                        // View user profile
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Focus Challenges',
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
                child: Column(
                  children: [
                    _buildChallengeItem(context, 'Weekly Focus Marathon',
                        'Complete 10 hours of focus this week.', 'Ongoing'),
                    _buildChallengeItem(context, 'Study Buddy Challenge',
                        'Focus 3 hours with a friend.', 'Completed'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Navigate to friends list
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Add Friends'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: appColor.mainColor,
                    side: const BorderSide(color: appColor.mainColor),
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

  Widget _buildChallengeItem(
      BuildContext context, String title, String description, String status) {
    return ListTile(
      leading: Icon(Icons.emoji_events, color: Colors.amber[600]),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(description),
      trailing: Chip(
        label: Text(status),
        backgroundColor:
            status == 'Completed' ? Colors.green[100] : Colors.blue[100],
        labelStyle: TextStyle(
            color:
                status == 'Completed' ? Colors.green[800] : Colors.blue[800]),
      ),
      onTap: () {
        // View challenge details
      },
    );
  }
}
