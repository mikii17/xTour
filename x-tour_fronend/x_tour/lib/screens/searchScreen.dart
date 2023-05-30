import 'package:flutter/material.dart';
import '../custom/custom.dart';
import 'profileScreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';
  bool isTop = true;
  bool isPost = false;
  bool isAccount = false;
  bool isJournal = false;
  List postImages = [
    "assets/person_cesare.jpeg",
    "assets/person_crispy.png",
    "assets/person_joe.jpeg",
    "assets/person_kevin.jpeg",
    "assets/person_kelvin.jpg",
    "assets/person_katz.jpeg"
  ];
  List JournalImages = [
    "assets/person_sandra.jpeg",
    "assets/person_stef.jpeg",
    "assets/person_tiffani.jpeg",
    "assets/food_spaghetti.jpg",
    "assets/person_cesare.jpeg",
    "assets/person_crispy.png"
  ];
  List topImages = [
    "assets/food_brussels_sprouts.jpg",
    "assets/food_burger.jpg",
    "assets/food_cucumber.jpg",
    "assets/food_cupcake.jpg",
    "assets/food_curry.jpg",
    "assets/food_pho.jpg",
  ];
  List accountImages = [
    "assets/person_kelvin.jpg",
    "assets/person_katz.jpeg",
    "assets/person_sandra.jpeg",
    "assets/person_stef.jpeg",
    "assets/person_tiffani.jpeg",
    "assets/mag5.png"
  ];

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  List _getActiveImageList() {
    if (isPost) {
      return postImages;
    } else if (isTop) {
      return topImages;
    } else if (isAccount) {
      return accountImages;
    } else if (isJournal) {
      return JournalImages;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('X-tour Search')),
        ),
        body: Column(
          children: [
            SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: CustomTextField(
                labelText: 'Search',
                prefixIcon: Icons.search,
                onChanged: (text) {},
                borderRadius: 20,
                height: 35,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAccount = false;
                      isTop = true;
                      isJournal = false;
                      isPost = false;
                    });
                  },
                  child: Text(
                    'Top',
                    style: TextStyle(
                      fontSize: 16,
                      color: isTop ? Colors.blue : Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAccount = true;
                      isTop = false;
                      isJournal = false;
                      isPost = false;
                    });
                  },
                  child: Text(
                    'Accounts',
                    style: TextStyle(
                      fontSize: 16,
                      color: isAccount ? Colors.blue : Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAccount = false;
                      isTop = false;
                      isJournal = false;
                      isPost = true;
                    });
                  },
                  child: Text(
                    'Posts',
                    style: TextStyle(
                      fontSize: 16,
                      color: isPost ? Colors.blue : Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAccount = false;
                      isTop = false;
                      isJournal = true;
                      isPost = false;
                    });
                  },
                  child: Text(
                    'Journal',
                    style: TextStyle(
                      fontSize: 16,
                      color: isJournal ? Colors.blue : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: _getActiveImageList().length,
                itemBuilder: (BuildContext context, int index) {
                  final String imagePath = _getActiveImageList()[index];

                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
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
  }
}
