// ignore_for_file: unused_import

import 'package:feed/chat.dart';
import 'package:feed/splash_screen.dart';
import 'package:flutter/material.dart';
import 'create.dart'; // Import the create.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHANCE'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
        bottom: _currentIndex == 0 || _currentIndex == 1
            ? PreferredSize(
                preferredSize: Size.fromHeight(48),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.green,
                  tabs: [
                    Tab(text: 'Public Feed'),
                    Tab(text: 'Business Feed'),
                  ],
                ),
              )
            : null,
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_currentIndex == 2) {
      return CreateScreen(); 
    } else if (_currentIndex == 3) {
      return ChatScreen();
    } else {
      return TabBarView(
        controller: _tabController,
        children: [
          _buildFeedList(),
          _buildFeedList(),
        ],
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildFeedList() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FeedCard(
              imageAsset: AssetImage('assets/images/person.png'),
            ),
          );
        },
      ),
    );
  }
}

class FeedCard extends StatelessWidget {
  final String? imageUrl;
  final ImageProvider? imageAsset;

  const FeedCard({Key? key, this.imageUrl = '', this.imageAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/person.png'),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "James",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.check_circle, color: Colors.green, size: 16),
                      ],
                    ),
                    Text(
                      "1 hour ago",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "Topic name",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.more_vert),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Lorem ipsum dolor sit amet consectetur. Sagittis diam auctor convallis justo pellentesque in eu amet sapien. Arcu pellentesque...",
              style: TextStyle(color: Colors.black),
            ),
            if (imageUrl!.isNotEmpty || imageAsset != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: imageAsset != null
                      ? Image(image: imageAsset!)
                      : Image.network(imageUrl!),
                ),
              ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.chat_bubble_outline),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.share),
                SizedBox(
                  width: 150,
                ),
                Icon(Icons.save_alt_outlined),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
