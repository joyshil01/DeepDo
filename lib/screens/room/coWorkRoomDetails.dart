import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CoWorkingRoomDetailScreen extends StatefulWidget {
  final String roomId;
  final String roomName;

  const CoWorkingRoomDetailScreen(
      {Key? key, required this.roomId, required this.roomName})
      : super(key: key);

  @override
  State<CoWorkingRoomDetailScreen> createState() =>
      _CoWorkingRoomDetailScreenState();
}

class _CoWorkingRoomDetailScreenState extends State<CoWorkingRoomDetailScreen> {
  bool _isMuted = false;
  bool _isVideoOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.roomName),
        backgroundColor: appColor.mainColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              // Leave room logic
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Placeholder for video feeds / participant display
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.black12,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Active participants in ${widget.roomName}',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black54)),
                    const SizedBox(height: 10),
                    // In a real app, this would be WebRTC video feeds
                    const Text('Video Streams / Avatars here',
                        style: TextStyle(color: Colors.black45)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(_isMuted ? Icons.mic_off : Icons.mic),
                      onPressed: () {
                        setState(() {
                          _isMuted = !_isMuted;
                        });
                        // Toggle microphone state in WebRTC
                      },
                      color: appColor.mainColor,
                      iconSize: 30,
                    ),
                    Text(_isMuted ? 'Unmute' : 'Mute'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                          _isVideoOn ? Icons.videocam : Icons.videocam_off),
                      onPressed: () {
                        setState(() {
                          _isVideoOn = !_isVideoOn;
                        });
                        // Toggle video state in WebRTC
                      },
                      color: appColor.mainColor,
                      iconSize: 30,
                    ),
                    Text(_isVideoOn ? 'Video On' : 'Video Off'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.timer),
                      onPressed: () {
                        // Sync group Pomodoro (e.g., show group timer status)
                      },
                      color: appColor.mainColor,
                      iconSize: 30,
                    ),
                    const Text('Sync Timer'),
                  ],
                ),
              ],
            ),
          ),
          // Chat window (simplified)
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(top: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 3, // Example chat messages
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                              'User ${index + 1}: This is a chat message.',
                              style: const TextStyle(fontSize: 14)),
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: appColor.mainColor,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: appColor.mainColor,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: appColor.mainColor,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          // Send chat message
                        },
                        color: appColor.mainColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
