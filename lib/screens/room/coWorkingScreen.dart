// ignore_for_file: deprecated_member_use, dead_code

import 'dart:io';

import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import 'coWorkRoomDetails.dart';

class CoWorkingRoomsScreen extends StatefulWidget {
  const CoWorkingRoomsScreen({Key? key}) : super(key: key);

  @override
  State<CoWorkingRoomsScreen> createState() => _CoWorkingRoomsScreenState();
}

class _CoWorkingRoomsScreenState extends State<CoWorkingRoomsScreen> {
  // Example list of rooms (fetched from Firebase Firestore in real app)
  final List<Map<String, dynamic>> _rooms = [
    {'name': 'Silent Study Group 1', 'participants': 12, 'id': 'room1'},
    {'name': 'Deep Work Session', 'participants': 5, 'id': 'room2'},
    {'name': 'Creative Brainstorm', 'participants': 3, 'id': 'room3'},
    {'name': 'Coding Marathon', 'participants': 8, 'id': 'room4'},
  ];

  void _joinRoom(String roomId, String roomName) {
    // Implement WebRTC connection logic here
    print('Joining room: $roomName ($roomId)');
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            CoWorkingRoomDetailScreen(roomId: roomId, roomName: roomName),
      ),
    );
  }

  void _createRoom() {
    // Show a dialog or navigate to a screen to create a new room
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Room'),
        content: TextField(
          decoration: const InputDecoration(hintText: 'Enter room name'),
          onSubmitted: (name) {
            if (name.isNotEmpty) {
              // Add room to Firebase and then join
              print('Creating room: $name');
              Navigator.pop(context); // Close dialog
              _joinRoom('new_room_id', name); // Simulate joining
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
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
          title: const Text('Virtual Co-Working Rooms'),
          automaticallyImplyLeading: false, // Hide back button
          backgroundColor: appColor.mainColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: _createRoom,
                icon: const Icon(Icons.add),
                label: const Text('Create New Room'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColor.mainColor,
                  foregroundColor: Colors.white,
                  minimumSize:
                      const Size.fromHeight(50), // Make button full width
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                itemCount: _rooms.length,
                itemBuilder: (context, index) {
                  final room = _rooms[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: CircleAvatar(
                        backgroundColor: appColor.mainColor[100],
                        child:
                            const Icon(Icons.group, color: appColor.mainColor),
                      ),
                      title: Text(
                        room['name'],
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900]),
                      ),
                      subtitle: Text(
                        '${room['participants']} active participants',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () => _joinRoom(room['id'], room['name']),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColor.mainColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Join'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Conceptual detail screen for a co-working room
