import 'package:flutter/material.dart';
import '../screens/screens.dart'; // Replace 'path_to_post_card' with the actual path to your PostCard widget

class PostListScreen extends StatefulWidget {
  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  // final List<Object?> posts = [
  // ]; 
 // Add your post objects to this list
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post List'),
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          // final post = posts[index];
          return PostCard();
        },
      ),
    );
  }
}
