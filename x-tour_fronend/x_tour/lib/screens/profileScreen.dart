import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_tour/custom/custom.dart';
import 'package:x_tour/routes/route_constants.dart';
import '../routes/router.dart';
import '../custom/custom_button.dart';

class ProfileScreen extends StatefulWidget {

  // ProfileScreen({
  //   this.proImageUrl = '',
  //   required this.name,
  //   this.password = '',
  //   required this.username,

  // });

  String name = '';
  String username = '';
  String password = '';
  String proImageUrl = '';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  bool isDarkTheme = false;
  bool showPost = true;
  bool showPendingImages = false;
  bool showPendingJournal = false;
  bool showPostJournal = false;
  bool showBookmark = false;
  Color postIconColor = Colors.blue;
  Color pendingIconColor = Colors.grey;
  Color postJournalIconColor = Colors.grey;
  Color pendingJournalIconColor = Colors.grey;
  Color bookmarkColor = Colors.grey;

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
  final List<String> usernames = ["zele", "mike", "leul","Abiy","Roman","Selam",];
  final List<String> names = ["zelalem", "michael", "leul","abi","Romi","Seli",];

  List postImages = [
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
    "assets/person_katz.jpeg",
    "assets/person_sandra.jpeg",
    "assets/person_stef.jpeg",
    "assets/person_tiffani.jpeg",
    "assets/mag5.png"
  ];

  List pendingImages = [
    "assets/person_cesare.jpeg",
    "assets/person_crispy.png",
    "assets/person_joe.jpeg",
    "assets/person_kevin.jpeg",
    "assets/person_kelvin.jpg",
    "assets/person_katz.jpeg",
    "assets/person_sandra.jpeg",
    "assets/person_stef.jpeg",
    "assets/person_tiffani.jpeg"
  ];


// void _showPopupMenu() {


   
//       items: [
//         PopupMenuItem(
//           child: ListTile(
//             leading: Icon(Icons.edit),
//             title: Text('Edit Pending Post'),
//             onTap: () {
//               GoRouter.of(context).go('/profile/editPendingPost');
//             },
//           ),
//         ),
//         PopupMenuItem(
//           child: ListTile(
//             leading: Icon(Icons.edit),
//             title: Text('Edit Pending Journal'),
//             onTap: () {
//               GoRouter.of(context).go('/profile/editPendingJournal');
//             },
//           ),
//         ),
//         PopupMenuItem(
//           child: ListTile(
//             leading: Icon(Icons.brightness_medium),
//             title: DropdownButton<String>(
//               value: isDarkTheme ? 'Dark Theme' : 'Light Theme',
//               onChanged: (String? value) {
//                 setState(() {
//                   isDarkTheme = !isDarkTheme; // Toggle the theme
//                   // Apply theme logic here, e.g., using ThemeProvider package or custom logic
//                   // You can set the dark theme based on the value of isDarkTheme
//                 });
//               },
//               items: <String>['Light Theme', 'Dark Theme'].map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//         PopupMenuItem(
//           child: ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('Logout'),
//             onTap: () {
//               // Handle logout
//               Navigator.pop(context);
//             },
//           ),
//         ),
//       ],
//     );
//   }


  @override
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: XTourAppBar(
        title: 'Dani',
        showActionIcon: IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){
          showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: -35,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color.fromARGB(255, 14, 201,
                                    55), // Replace with your desired border color
                                width: 3, // Adjust the width of the border
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 35.0,
                              backgroundImage: NetworkImage(
                                  ''), // Replace with actual image URL
                              child: Icon(
                                Icons.person,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Username', // Replace with actual username
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Name', // Replace with actual name
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              PopupMenuItem(
                                child: ListTile(
                                  leading: Icon(Icons.hourglass_bottom),
                                  title: Text('Pending Post'),
                                  onTap: () {
                                    GoRouter.of(context)
                                        .go('/profile/editPendingPost');
                                  },
                                ),
                              ),
                              PopupMenuItem(
                                child: ListTile(
                                  leading: Icon(Icons.pending_actions),
                                  title: Text('Pending Journal'),
                                  onTap: () {
                                    GoRouter.of(context)
                                        .go('/profile/editPendingJournal');
                                  },
                                ),
                              ),
                              PopupMenuItem(
                                child: ListTile(
                                  leading: Icon(Icons.logout),
                                  title: Text('Logout'),
                                  onTap: () {
                                    // Handle logout
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );

            }
          ),
        ),
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
               const Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                       
                SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     GestureDetector(
                      onTap: () {
                       showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                height: 500,
                              
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Followers',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: usernames.length,
                                        itemBuilder: (BuildContext context,
                                            int index) {
                                          return ListTile(
                                            leading: CircleAvatar(
                                              maxRadius: 20,
                                              backgroundColor: Colors.black,
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                            title: Text(usernames[index]),
                                            subtitle: Text(names[index]),
                                            trailing: ElevatedButton(
                                              onPressed: () {
                                                // Perform the follow back action here
                                              },
                                              child: Text('Follow Back'),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.green,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                      },
                      child: Column(
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
                    ),
                    Column(
                      children: [  
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors
                                  .red, // Replace with your desired border color
                              width: 3, // Adjust the width of the border
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                                ''), // Replace with actual image URL
                            child: Icon(
                              Icons.person,
                            ),
                          ),
                        ),

                        SizedBox(height: 16.0),
                        
                      ],
                    ),
                    
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                               shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                ),
                              child: Container(
                                height: 500,
                                width: 600,
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Following',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: usernames.length,
                                        itemBuilder: (BuildContext context,
                                            int index) {
                                          return ListTile(
                                            leading: CircleAvatar(
                                              maxRadius: 20,
                                              backgroundColor: Colors.black,
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                            title: Text(usernames[index]),
                                            subtitle: Text(names[index]),
                                            trailing: ElevatedButton(
                                              onPressed: () {
                                                // Perform the follow back action here
                                              },
                                              child: Text('Unfollow'),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.green,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                      },
                      child: Column(
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
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                // CustomButton(
                //   text: "Edit Profile",
                //   onPressed: () {
                //     GoRouter.of(context).go('/profile/editProfile');
                //   },
                //   textColor: Colors.black,
                //   backgroundGradient: const [
                //     Colors.white,
                //     Colors.white,
                //   ],
                //   width: 150,
                // ),

              ],
            ),
          ),
          const Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          const SizedBox(
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
                    showBookmark = false;
                    postIconColor = Colors.blue;
                    postJournalIconColor = Colors.grey;
                    bookmarkColor = Colors.grey;
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
                    showBookmark = false;
                    showPost = false;
                    showPostJournal = true;
                    postIconColor = Colors.grey;
                    postJournalIconColor = Colors.blue;
                    bookmarkColor = Colors.grey;
                  });
                },
                child: Icon(
                  Icons.article_outlined,
                  color: postJournalIconColor,
                ),
              ),
              
              GestureDetector(
                onTap: () {
                  setState(() {
                    showBookmark = true;
                    showPost = false;
                    showPostJournal = false;
                    postIconColor = Colors.grey;
                    postJournalIconColor = Colors.grey;
                    bookmarkColor = Colors.blue;
                  });
                },
                child: Icon(
                  Icons.bookmark_add,
                  color: bookmarkColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: showPost
                    ? 3
                    : showBookmark
                        ? 3
                            : showPostJournal
                                ? 2
                                    : pendingImages.length,
              ),
              itemCount:showPost
                      ? postImages.length
                      : showPostJournal
                          ? cardData.length: postImages.length,
              itemBuilder: (BuildContext context, int index) {
                if (showPendingImages) {
                  // Render pending images
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(pendingImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  // Check which icon is selected
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
                  // } else if (pendingJournalIconColor == Colors.blue) {
                  //   // Render cardData
                  // //   final data = cardData[index];
                  //   return _buildCard(
                  //     image: data['image'],
                  //     link: data['link'],
                  //   );
                  } else {
                    // Render post images
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(postImages[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

