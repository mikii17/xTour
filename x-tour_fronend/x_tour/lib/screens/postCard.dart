import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../custom/custom.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'commentScreen.dart';

class PostCard extends StatefulWidget {
  PostCard({
    Key? key,
    this.post,
    this.user,
  }) : super(key: key);

  final Object? post;
  final Object? user;

  @override
  PostState createState() => PostState();
}

class PostState extends State<PostCard> {
  final PageController _pageController = PageController();
  bool showAdditionalText = false;
  int? _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.toInt();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 80, 78, 78)),
      // padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
         Container(
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 98, 97, 96),
      borderRadius: BorderRadius.circular(20.0),
    ),
    // padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        userCard(),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Text(
            "Here's an example that adds 16 pixels of vertical padding and 32 pixels of horizontal padding.",
            style: TextStyle(
              color: Color.fromARGB(255, 242, 239, 239),
              fontSize: 13,
            ),
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: [
            photoList(),
            DotsIndicator(
              dotsCount: 3,
              position: _currentPage ?? 0,
              decorator: DotsDecorator(
                activeColor: Color.fromARGB(255, 167, 212, 228),
                size: Size.square(8.0),
                activeSize: Size(20.0, 8.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Row(
            children: [
              Container(
                width: 70,
                child: Stack(
                  children: [
                    Positioned(
                      child: profile_avatar(
                        imageUrl: "assets/food_brussels_sprouts.jpg",
                        radius: 30,
                      ),
                    ),
                    Positioned(
                      left: 20,
                      child: profile_avatar(
                        imageUrl: "assets/food_burger.jpg",
                        radius: 30,
                      ),
                    ),
                    Positioned(
                      left: 40,
                      child: profile_avatar(
                        imageUrl: "assets/person_joe.jpeg",
                        radius: 30,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Text(
                'liked by Abebech and 120 others',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 251, 249, 249),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 7),
          child: GestureDetector(
            onTap: () {
              setState(() {
                showAdditionalText = !showAdditionalText;
              });
              // Handle description button press event
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!showAdditionalText)
                  Text(
                    'View description',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 240, 237, 237),
                    ),
                  ),
                if (showAdditionalText)
                  Text(
                    'these are the the things I saw in behamas the one thing I saw is that they always like to cheat on their mate and dont even feel ashamed at all',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 184, 184, 185),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commentBuilder('I am gonna kill you'),
              commentBuilder('well done boys'),
              commentBuilder('amigos bitch'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              GoRouter.of(context).go('/comments');
            },
            child: Text(
              'view all 16 comments',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 251, 249, 249),
              ),
            ),
          ),
        ),
      ],
    ),
  )
        ],
      ),
    );
  }

  Widget userCard() {
    return Container(
      padding: const EdgeInsets.only(left: 13,top: 10),
      child: Row(
        children: [
          profile_avatar(
            imageUrl: "assets/food_spaghetti.jpg",
            radius: 60,
          ),
          const SizedBox(width: 10),
          const Text(
            "Leul Abay",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    );
  }
Widget photoList() {
    return Container(
      width: double.infinity,
      height: 350, // Set the height as needed
      child: Stack(
        children: [
          PageView.builder(
            itemCount: 3,
            controller: _pageController,
            itemBuilder: (context, index) {
              return   Stack(
            children: [
              Image.asset(
                "assets/food_salmon.jpg",
                width: double.infinity,
                height: 400, // Adjust the width as needed
                fit: BoxFit.cover,
              ),
              Container(
                height: 400,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black],
                    // begin: Alignment.left,
                    // end: Alignment.bottomCenter,
                    stops: [0.7, 1],
                  ),
                ),
              ),]
              );
            },
          ),
          Positioned(
            right: 20,
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  child: iconBuilder(Icons.favorite_border_rounded),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.7, // Set the desired height for the bottom sheet
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: XtourCommentSection(),
                        );
                      },
                    );
                  },
                  child: iconBuilder(Icons.comment_outlined),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {},
                  child: iconBuilder(Icons.share),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {},
                  child: iconBuilder(Icons.bookmark_add_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }





  Widget iconBuilder(iconData) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [
            Color.fromARGB(255, 97, 38, 234),
            Color.fromARGB(255, 19, 158, 180)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.3, 0.75],
        ).createShader(bounds);
      },
      child: Icon(
        iconData,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  Widget commentBuilder(commentText) {
    return Text(
      commentText,
      style: TextStyle(
        fontSize: 13,
        color: const Color.fromARGB(255, 177, 169, 169),
      ),
      overflow: TextOverflow.fade,
      maxLines: 1,
    );
  }
}
