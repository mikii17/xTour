import 'package:flutter/material.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({Key? key}) : super(key: key);

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  final List usernames = ["zele", "mike", "leul"];
  final List names = ["zelalem", "michael", "leul"];
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Following'),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: usernames.length, // Set the number of items in the list
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      maxRadius: 25,
                      backgroundColor: Colors.black,
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          usernames[index],
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          names[index],
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Unfollow'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 10,
            );
          },
        ),
      ),
    );
  }
}
