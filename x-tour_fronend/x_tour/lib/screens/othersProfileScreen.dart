import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_tour/routes/route_constants.dart';
import '../routes/router.dart';
import '../custom/custom_button.dart';

class OtherProfileScreen extends StatefulWidget {
  String name = '';
  String username = '';
  String password = '';
  String proImageUrl = '';

  @override
  _OtherProfileScreenState createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  bool isDarkTheme = false;
  bool showPost = true;
  bool showPostJournal = false;
  Color postIconColor = Colors.blue;
  Color postJournalIconColor = Colors.grey;

  final List<Map<String, dynamic>> cardData = [
    {
      'image': "assets/food_curry.jpg",
      'link': 'https://www.youtube.com/',
    },
    {
      'image': "assets/food_cupcake.jpg",
      'link': 'https://example.com/card2',
    },
    {
      'image': "assets/food_salmon.jpg",
      'link': 'https://example.com/card3',
    },
    {
      'image': "assets/food_curry.jpg",
      'link': 'https://example.com/card1',
    },
    {
      'image': "assets/food_cupcake.jpg",
      'link': 'https://example.com/card2',
    },
    {
      'image': "assets/food_salmon.jpg",
      'link': 'https://example.com/card3',
    },
  ];

  List<String> postImages = [
    "assets/food_brussels_sprouts.jpg",
    "assets/food_burger.jpg",
    "assets/food_cucumber.jpg",
    "assets/food_cupcake.jpg",
    "assets/food_curry.jpg",
    "assets/food_pho.jpg",
    "assets/food_salmon.jpg",
    "assets/food_soymilk.png",
    "assets/food_spaghetti.jpg",
    "assets/person_cesare.jpeg",
    "assets/person_crispy.png",
    "assets/person_joe.jpeg",
    "assets/person_kevin.jpeg",
    "assets/person_kelvin.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('X-tour OtherProfile')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                          NetworkImage(''), // Replace with actual image URL
                      child: Icon(
                        Icons.person,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 12.0,
                        backgroundColor:
                            const Color.fromARGB(255, 33, 58, 243),
                        child: IconButton(
                          icon: const Icon(
                            Icons.add,
                            size: 14,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            // Add image functionality
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                const Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '123', // Replace with actual post count
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Posts',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '456K', // Replace with actual follower count
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Followers',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '789', // Replace with actual following count
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Following',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showPost = true;
                    showPostJournal = false;
                    postIconColor = Colors.blue;
                    postJournalIconColor = Colors.grey;
                  });
                },
                child: Icon(
                  Icons.photo_library,
                  color: postIconColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showPost = false;
                    showPostJournal = true;
                    postIconColor = Colors.grey;
                    postJournalIconColor = Colors.blue;
                  });
                },
                child: Icon(
                  Icons.playlist_add,
                  color: postJournalIconColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: showPost ? 3 : 2,
              ),
              itemCount: showPost ? postImages.length : cardData.length,
              itemBuilder: (BuildContext context, int index) {
                if (postIconColor == Colors.blue) {
                  // Render post images
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(postImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else if (postJournalIconColor == Colors.blue) {
                  // Render cardData
                  final data = cardData[index];
                  return _buildCard(
                    image: data['image'],
                    link: data['link'],
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required String image, required String link}) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Here is a link',
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
