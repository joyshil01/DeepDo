// ignore_for_file: deprecated_member_use, dead_code

import 'dart:io';

import 'package:deepdo/utils/colors.dart'; // Assuming this file defines appColor.mainColor
import 'package:flutter/material.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({Key? key}) : super(key: key);

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages =
      []; // Stores chat messages: {'sender': 'user/ai', 'text': 'message'}

  // Function to send a message and simulate AI response
  void _sendMessage() async {
    final text = _messageController.text.trim(); // Trim whitespace
    if (text.isEmpty) {
      // If message is empty, do not send
      print('Message is empty, not sending.');
      return;
    }

    // Add user's message to the chat history
    setState(() {
      _messages.add({'sender': 'user', 'text': text});
    });
    _messageController.clear(); // Clear the input field

    // Simulate AI thinking response
    setState(() {
      _messages.add(
          {'sender': 'ai', 'text': 'Thanks for your query! I am thinking...'});
    });

    // Simulate a delay for AI processing
    await Future.delayed(const Duration(seconds: 2));

    // Determine AI response based on user input
    String aiResponse;
    if (text.toLowerCase().contains('task')) {
      aiResponse =
          'Sure, how about these tasks for today:\n- Finish Chapter 3 of Flutter book\n- Plan week\'s meals\n- Meditate for 10 mins';
    } else if (text.toLowerCase().contains('schedule')) {
      aiResponse =
          'To help with your schedule, I can suggest a Pomodoro session for your next task. Would you like to try 25/5 min interval?';
    } else {
      aiResponse = 'I understand. What else can I help you with?';
    }

    // Update the last AI message (the "thinking" one) or add a new one
    setState(() {
      // Find the "thinking" message and update it
      int thinkingIndex = _messages.indexWhere(
          (msg) => msg['text'] == 'Thanks for your query! I am thinking...');
      if (thinkingIndex != -1) {
        _messages[thinkingIndex] = {'sender': 'ai', 'text': aiResponse};
      } else {
        // Fallback: add as a new message if "thinking" message wasn't found
        _messages.add({'sender': 'ai', 'text': aiResponse});
      }
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
          title: const Text('AI Productivity Assistant'),
          automaticallyImplyLeading:
              false, // Managed by MainWrapper's bottom nav
          backgroundColor: appColor.mainColor, // Uses your custom color
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: _messages.isEmpty // Check if chat history is empty
                  ? Center(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 70),
                          // Animated icon for empty state
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(
                                begin: 0.8, end: 1.2), // Scale from 0.8 to 1.2
                            duration: const Duration(
                                milliseconds: 800), // Animation duration
                            curve: Curves.easeInOut, // Smooth animation curve
                            builder: (context, scale, child) {
                              return Transform.scale(
                                scale: scale,
                                child: Icon(
                                  Icons
                                      .psychology_outlined, // A relevant icon for AI/thinking
                                  size: 80,
                                  color: appColor.mainColor
                                      .withOpacity(0.6), // Subtle main color
                                ),
                              );
                            },
                            // This allows the animation to repeat
                            // Consider using a dedicated animation controller for more complex loops
                            onEnd: () {
                              setState(() {
                                // Trigger rebuild to restart animation
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'What can I help with?',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          // const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Ask me about tasks, schedules, or focus techniques.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12.0),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        final bool isUser = message['sender'] == 'user';
                        return Align(
                          alignment: isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: isUser
                                  ? appColor.mainColor[
                                      100] // Light shade for user messages
                                  : Colors.grey[200], // Grey for AI messages
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Text(
                              message['text']!,
                              style: TextStyle(
                                  color: isUser
                                      ? appColor.mainColor[
                                          900] // Dark shade for user text
                                      : Colors.black87),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Ask me anything...',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: appColor.mainColor, // Border color
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: appColor.mainColor, // Focused border color
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: appColor.mainColor, // Enabled border color
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    onPressed: _sendMessage,
                    backgroundColor: appColor.mainColor, // FAB background color
                    foregroundColor: Colors.white, // FAB icon color
                    mini: true, // Smaller FAB
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
