import 'dart:math';
import 'package:feed/chat_detail.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final List<Message> messages = List.generate(
    8,
    (index) => Message(
      sender: 'Bruno Pham',
      text: 'Hello, I really like your post about...',
      time: '2 mins ago',
      unreadCount: 5,
    ),
  );

  final List<String> avatarImages = [
    'assets/images/person1.png',
    'assets/images/person2.png',
    'assets/images/person3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Message',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              // Handle new message action
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return MessageCard(
            message: messages[index],
            avatarImage: avatarImages[Random().nextInt(avatarImages.length)],
          );
        },
      ),
    );
  }
}

class Message {
  final String sender;
  final String text;
  final String time;
  final int unreadCount;

  Message({
    required this.sender,
    required this.text,
    required this.time,
    required this.unreadCount,
  });
}

// chat.dart

// Import the new chat detail screen
class MessageCard extends StatelessWidget {
  final Message message;
  final String avatarImage;

  const MessageCard(
      {Key? key, required this.message, required this.avatarImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(
              sender: message.sender,
              receiver:
                  'Random User', // Set the receiver name or logic as needed
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          contentPadding: EdgeInsets.all(12),
          leading: CircleAvatar(
            backgroundImage: AssetImage(avatarImage),
          ),
          title: Text(
            message.sender,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(message.text),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message.time, style: TextStyle(color: Colors.grey)),
              SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.chat_bubble_outline, color: Colors.grey),
                  SizedBox(width: 4),
                  Text('${message.unreadCount}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
