import 'package:flutter/material.dart';

class FollowerScreen extends StatefulWidget {
  const FollowerScreen({Key? key}) : super(key: key);

  @override
  State<FollowerScreen> createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen> {

  final List usernames = ["zele","mike","leul"];
  final List names = ["zelalem", "michael","leul"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followers'),
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
                child: Text('Follow Back'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
              ),
            ],
          );
        }, separatorBuilder: (BuildContext context, int index) { 
          return SizedBox(height: 10,);
         },
      ),
    );
  }
}
