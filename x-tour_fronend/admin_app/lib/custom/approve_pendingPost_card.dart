import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:x_tour/admin/pending_post/model/post.dart';

import 'package:x_tour/custom/pofile_avatar.dart';

import '../admin/pending_post/bloc/pending_post_bloc.dart';


class PendingPostCard extends StatefulWidget {
  PendingPostCard({
    Key? key,
    required this.pendingPostBloc,
    required this.post,
  }) : super(key: key);

  final PendingPostBloc pendingPostBloc;
  final Posts post;

  @override
  PostState createState() => PostState();
}

class PostState extends State<PendingPostCard> {
  final PageController _pageController = PageController();
  bool isLiked = false;
  bool isBookmarked = false;
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
    final theme = Theme.of(context);
    return Material(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userCard(),
                  SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      widget.post.story,
                      style: theme.textTheme.bodyMedium,
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
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          if (showAdditionalText)
                            Text(
                              widget.post.description,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget userCard() {
    return Container(
      padding: const EdgeInsets.only(left: 13, top: 10),
      child: Row(
        children: [
          profile_avatar(
            imageUrl: widget.post.creator!.profilePicture!,
            radius: 60,
          ),
          const SizedBox(width: 10),
           Text(
            widget.post.creator!.username,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              widget.pendingPostBloc.add(ApprovePendingPost(id: widget.post.id!, post: widget.post));
            },
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              widget.pendingPostBloc.add(DeletePendingPost(id: widget.post.id!));
            },
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
            itemCount: widget.post.images!.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              return Stack(children: [
                Image.network(
                  widget.post.images![index],
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
                ),
              ]);
            },
          ),
        ],
      ),
    );
  }


 
}
