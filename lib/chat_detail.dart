// chat_detail.dart

import 'dart:math';
import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  final String sender;
  final String receiver;
  final List<String> avatarImages = [
    'assets/images/person1.png',
    'assets/images/person2.png',
    'assets/images/person3.png',
  ];

  ChatDetailScreen({
    required this.sender,
    required this.receiver,
  });

  @override
  Widget build(BuildContext context) {
    // Generate random avatar images for sender and receiver
    final senderAvatar = avatarImages[Random().nextInt(avatarImages.length)];
    final receiverAvatar = avatarImages[Random().nextInt(avatarImages.length)];

    return Scaffold(
      appBar: AppBar(
        title: Text('Bruno Pham'),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: [
                // Example messages with Lorem Ipsum text
                _buildMessage(
                    senderAvatar,
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    true),
                SizedBox(
                  height: 20,
                ),
                _buildMessage(
                    receiverAvatar,
                    'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    false),
                SizedBox(
                  height: 20,
                ),
                _buildMessage(
                    senderAvatar,
                    'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    true),
                SizedBox(
                  height: 20,
                ),
                _buildMessage(
                    receiverAvatar,
                    'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                    false),
                SizedBox(
                  height: 20,
                ),
                _buildMessage(
                    senderAvatar,
                    'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    true),
                SizedBox(
                  height: 20,
                ),
                // Add more messages here
              ],
            ),
          ),
          // Input field for new messages
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Handle send message action
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(String avatar, String text, bool isSender) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isSender)
            CircleAvatar(
              backgroundImage: AssetImage(avatar),
            ),
          SizedBox(width: 8),
          Expanded(
            // Ensure the text fits within its container
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSender ? Colors.blue : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black,
                ),
                overflow:
                    TextOverflow.ellipsis, // Handle overflow with ellipsis
              ),
            ),
          ),
          SizedBox(width: 8),
          if (isSender)
            CircleAvatar(
              backgroundImage: AssetImage(avatar),
            ),
        ],
      ),
    );
  }
}
