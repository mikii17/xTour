import 'package:flutter/material.dart';
import '../custom/custom.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  final String imageurl = '';
  final String name = '';
  final String username = '';
  final String password = '';
  
  // const EditProfileScreen({
  //   Key? key,
  //   this.imageurl ='',
  //   required this.name,
  //   required this.username,
  //   required this.password,
  // }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _nameController.text = "michael";
    _usernameController.text = "mike12";
    _passwordController.text = "12345678";

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          leading: Row(
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Edit Profile',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                // Save changes logic here
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Edit picture logic here
                      _editPicture();
                    },
                    child: profile_avatar(
                      radius: 100,
                      // Replace with your profile picture image provider
                      imageUrl: widget.imageurl,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Edit picture logic here
                      _editPicture();
                    },
                    child: Text(
                      'Edit Picture',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                Text(
                  'Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Username',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your username',
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _editPicture() {
    // Handle edit picture logic here
    print('Edit Picture');
  }
}

void main() {
  runApp(
    MaterialApp(
      home: EditProfileScreen(
      ),
    ),
  );
}
