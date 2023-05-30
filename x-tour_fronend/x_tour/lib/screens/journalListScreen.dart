import 'package:flutter/material.dart';
import '../screens/screens.dart'; // Replace 'path_to_post_card' with the actual path to your PostCard widget

class JournalListScreen extends StatefulWidget {
  @override
  State<JournalListScreen> createState() => _JournalListScreenState();
}

class _JournalListScreenState extends State<JournalListScreen> {
  // final List<Object?> posts = [
  // ]; 
 // Add your post objects to this list
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal List'),
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          // final post = posts[index];
          return journalCard();
        },
      ),
    );
  }
}
