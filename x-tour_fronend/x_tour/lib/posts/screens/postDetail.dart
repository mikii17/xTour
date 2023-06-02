import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:x_tour/custom/custom.dart';
import 'package:x_tour/posts/bloc/load_posts_bloc.dart' as lpb;
import 'package:x_tour/posts/models/post.dart';
import 'package:x_tour/screens/error_page.dart';
import 'package:x_tour/user/models/user.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:x_tour/comment/models/comment.dart' as model;

import 'package:x_tour/posts/post_detail/bloc/post_detail_bloc.dart';

import '../../comment/screens/commentScreen.dart';
import '../../user/bloc/user_bloc.dart';
import '../repository/post_repository.dart';

class PostDetailScreen extends StatefulWidget {
  PostDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  PostState createState() => PostState();
}

class PostState extends State<PostDetailScreen> {
  late final PostDetailBloc postDetailBloc;

  final PageController _pageController = PageController();
  bool showAdditionalText = false;
  int? _currentPage = 0;

  late bool liked;
  late bool bookmarked;

  @override
  void initState() {
    super.initState();
    postDetailBloc = PostDetailBloc(
        postRepository: context.read<PostRepository>(),
        userBloc: context.read<UserBloc>())
      ..add(LoadPostDetail(id: widget.id));
    // liked = widget.post.likes!.contains(widget.user.id);
    // bookmarked = widget.user.bookmarkPosts!.contains(widget.post.id);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.toInt();
      });
    });
  }

  @override
  void dispose() {
    postDetailBloc.close();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<PostDetailBloc, PostDetailState>(
      bloc: postDetailBloc,
      builder: (context, state) {
        if (state is PostDetailLoading) {
          Center(child: CircularProgressIndicator());
        }
        if (state is PostDetailFailed) {
          ErrorPage();
        }
        if (state is PostDetailLoaded) {
          final post = state.post;
          return Scaffold(
            appBar: XTourAppBar(title: ''),
            body: Container(
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
                    // padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        userCard(post),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Text(
                            post.story,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            photoList(post),
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
                                        imageUrl:
                                            post.likes![0].profilePicture! == ""
                                                ? ""
                                                : post.creator!.profilePicture!,
                                        radius: 30,
                                        isAsset:
                                            post.likes![0].profilePicture! ==
                                                "",
                                      ),
                                    ),
                                    Positioned(
                                      left: 20,
                                      child: profile_avatar(
                                        imageUrl:
                                            post.likes![1].profilePicture! == ""
                                                ? ""
                                                : post.creator!.profilePicture!,
                                        radius: 30,
                                        isAsset:
                                            post.likes![1].profilePicture! ==
                                                "",
                                      ),
                                    ),
                                    Positioned(
                                      left: 40,
                                      child: profile_avatar(
                                        imageUrl:
                                            post.likes![2].profilePicture! == ""
                                                ? ""
                                                : post.creator!.profilePicture!,
                                        radius: 30,
                                        isAsset:
                                            post.likes![2].profilePicture! ==
                                                "",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                'liked by ${post.likes![0].username} and ${post.likes!.length} others',
                                style: theme.textTheme.bodySmall,
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
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                if (showAdditionalText)
                                  Text(
                                    post.description,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
                              commentBuilder(
                                  (post.comments![0] as model.Comment).message),
                              commentBuilder(
                                  (post.comments![1] as model.Comment).message),
                              commentBuilder(
                                  (post.comments![2] as model.Comment).message),
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
                              'view all ${post.comments!.length} comments',
                              style: const TextStyle(
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
            ),
          );
        }
        return Text('Error');
      },
    );
  }

  Widget userCard(Posts post) {
    return Container(
      padding: const EdgeInsets.only(left: 13, top: 10),
      child: Row(
        children: [
          profile_avatar(
            imageUrl: post.creator!.profilePicture!,
            radius: 60,
          ),
          const SizedBox(width: 10),
          Text(
            post.creator!.username!,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget photoList(Posts post) {
    return Container(
      width: double.infinity,
      height: 350, // Set the height as needed
      child: Stack(
        children: [
          PageView.builder(
            itemCount: post.images!.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              return Stack(children: [
                Image.network(
                  post.images![index],
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
          Positioned(
            right: 20,
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    //TODO
                    // liked
                    //     ? widget.loadPostsBloc
                    //         .add(lpb.UnlikePost(id: widget.post.id!))
                    //     : widget.loadPostsBloc
                    //         .add(lpb.LikePost(id: widget.post.id!));
                    setState(() {
                      liked = !liked;
                    });
                  },
                  child: liked
                      ? iconBuilder(Icons.favorite_rounded)
                      : iconBuilder(Icons.favorite_outline_rounded),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height *
                              0.7, // Set the desired height for the bottom sheet
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: XtourCommentSection(
                            id: post.id!,
                          ),
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
                  onTap: () {
                    //TODO
                    // bookmarked
                    // ? widget.loadPostsBloc
                    //         .add(lpb.UnbookmarkPost(id: widget.post.id!))
                    //     : widget.loadPostsBloc
                    //         .add(lpb.BookmarkPost(id: widget.post.id!));
                    setState(() {
                      bookmarked = !bookmarked;
                    });
                  },
                  child: bookmarked
                      ? iconBuilder(Icons.bookmark_rounded)
                      : iconBuilder(Icons.bookmark_outline_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget iconBuilder(iconData) {
    return Icon(
      iconData,
      size: 30,
    );
  }

  Widget commentBuilder(commentText) {
    return Text(
      commentText,
      style: Theme.of(context).textTheme.bodySmall,
      overflow: TextOverflow.fade,
      maxLines: 1,
    );
  }
}
