import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  // Example notifications
  final List<Map<String, String>> _notifications = const [
    {
      'title': 'Break Time Reminder',
      'message': 'Your focus session ends in 5 minutes!'
    },
    {
      'title': 'New Task Suggested',
      'message': 'AI Assistant has new tasks for your day.'
    },
    {
      'title': 'Challenge Update',
      'message': 'You completed "Weekly Focus Marathon"!'
    },
    {
      'title': 'Room Invitation',
      'message': 'John invited you to "Deep Work Session".'
    },
    {
      'title': 'Daily Plan Ready',
      'message': 'Your daily productivity report is ready.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: appColor.mainColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off,
                      size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No new notifications',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 4.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: appColor.mainColor[100],
                      child: const Icon(
                        Icons.notifications_active,
                        color: appColor.mainColor,
                      ),
                    ),
                    title: Text(
                      notification['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(notification['message']!),
                    onTap: () {
                      // Handle notification tap (e.g., navigate to relevant screen)
                      print('Tapped on notification: ${notification['title']}');
                    },
                  ),
                );
              },
            ),
    );
  }
}
