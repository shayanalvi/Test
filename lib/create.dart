import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _postController = TextEditingController();
  XFile? _imageFile;
  final List<String> _topics = [
    'Climate Change & Sustainability',
    'Conscious Art',
  ];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Create Post', style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () {
              // Handle post action here
            },
            child: Text(
              'Post',
              style: TextStyle(color: Colors.green, fontSize: 16),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _postController,
                decoration: InputDecoration(
                  hintText: 'Type something',
                  border: InputBorder.none,
                ),
                maxLines: 5,
              ),
              SizedBox(height: 16),
              Text(
                'Topic',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: _topics.map((topic) {
                  return Chip(
                    label: Text(topic),
                    backgroundColor: _topics.indexOf(topic) == 0
                        ? Colors.green
                        : Colors.white,
                    labelStyle: TextStyle(
                        color: _topics.indexOf(topic) == 0
                            ? Colors.white
                            : Colors.black),
                    shape: StadiumBorder(
                      side: BorderSide(
                          color: _topics.indexOf(topic) == 0
                              ? Colors.transparent
                              : Colors.grey),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              if (_imageFile != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 200,
                    ),
                    child: Image.file(
                      File(_imageFile!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.photo_camera, color: Colors.blue),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                  IconButton(
                    icon: Icon(Icons.photo_library, color: Colors.blue),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
