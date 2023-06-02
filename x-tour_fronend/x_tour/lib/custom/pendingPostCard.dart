import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_tour/posts/models/post.dart';
import 'package:x_tour/user/models/user.dart';
import '../custom/custom.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../user/bloc/user_bloc.dart';
import '../user/pending_posts/bloc/pending_posts_bloc.dart';

class PendingPostCard extends StatefulWidget {
  PendingPostCard(
      {Key? key,
      required this.post,
      required this.user,
      required this.userBloc,
      required this.pendingPostsBloc})
      : super(key: key);

  final Posts post;
  final User user;
  final UserBloc userBloc;
  final PendingPostsBloc pendingPostsBloc;

  @override
  PostState createState() => PostState();
}

class PostState extends State<PendingPostCard> {
  final PageController _pageController = PageController();
  late bool isLiked;
  late bool isBookmarked;
  bool showAdditionalText = false;
  int? _currentPage = 0;

  @override
  void initState() {
    super.initState();
    isLiked = widget.post.likes!.contains(widget.user.id);
    isBookmarked = widget.user.bookmarkPosts!.contains(widget.post.id);
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
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userCard(widget.pendingPostsBloc, widget.post),
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
                      photoList(widget.post),
                      DotsIndicator(
                        dotsCount: widget.post.images!.length,
                        position: _currentPage ?? 0,
                        decorator: DotsDecorator(
                          activeColor: theme.primaryColor,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget userCard(PendingPostsBloc pendingPostsBloc, Posts post) {
    return Container(
      padding: const EdgeInsets.only(left: 13, top: 10),
      child: Row(
        children: [
          profile_avatar(
            imageUrl: post.creator!.profilePicture != ""
                ? post.creator!.profilePicture!
                : "assets/person_sandra.jpeg",
            // TODO
            radius: 60,
            isAsset: post.creator!.profilePicture == "",
          ),
          const SizedBox(width: 10),
          Text(
            post.creator!.username!,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              GoRouter.of(context)
                  .go('/profile/showPendingPost/editPendingPost');
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDeleteConfirmationDialog(context, pendingPostsBloc, post);
            },
          ),
        ],
      ),
    );
  }

  Widget photoList(Posts post) {
    final List<String> images = post.images!;
    return Container(
      width: double.infinity,
      height: 350,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: images.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              return Stack(children: [
                Image.network(
                  "http://10.0.2.2/${images[0]}", // TODO
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black],
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

  void showDeleteConfirmationDialog(
      BuildContext context, PendingPostsBloc pendingPostsBloc, Posts post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this post?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                pendingPostsBloc.add(DeletePendingPost(id: post.id!));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
