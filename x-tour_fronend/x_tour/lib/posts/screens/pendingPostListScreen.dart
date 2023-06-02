import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_tour/custom/custom.dart';
import 'package:x_tour/user/pending_posts/bloc/pending_posts_bloc.dart';
import '../../custom/pendingPostCard.dart';
import '../../user/bloc/user_bloc.dart';
import '../../user/repository/user_repository.dart';
import '../models/post.dart';
import '../repository/post_repository.dart';

class PendingPostListScreen extends StatefulWidget {
  @override
  State<PendingPostListScreen> createState() => _PendingPostListScreenState();
}

class _PendingPostListScreenState extends State<PendingPostListScreen> {
  late PendingPostsBloc pendingPostsBloc;
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
    pendingPostsBloc = PendingPostsBloc(
        userRepository: context.read<UserRepository>(),
        postRepository: context.read<PostRepository>(),
        userBloc: userBloc)
      ..add(const GetPendingPost());
  }

  @override
  void dispose() {
    pendingPostsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PendingPostsBloc, PendingPostsState>(
      bloc: pendingPostsBloc,
      builder: (context, state) {
        if (state is PendingPostsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PendingPostsOperationSuccess) {
          final List<Posts> posts = state.posts;
          print("posts");
          return Scaffold(
            appBar: const XTourAppBar(
              title: 'Pending Post List',
            ),
            body: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PendingPostCard(
                  pendingPostsBloc: pendingPostsBloc,
                  post: posts[index],
                  user: (userBloc.state as UserOperationSuccess).user,
                  userBloc: userBloc,
                );
              },
            ),
          );
        }
        return Container(
          child: Text("dfef"),
        ); // TODO
      },
    );
  }
}
