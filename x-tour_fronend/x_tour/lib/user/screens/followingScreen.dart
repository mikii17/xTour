import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_tour/screens/error_page.dart';
import 'package:x_tour/user/bloc/user_bloc.dart' as ubloc;
import 'package:x_tour/user/following/bloc/following_bloc.dart';
import 'package:x_tour/user/repository/user_repository.dart';

import '../../custom/avator_custom.dart';
import '../models/user.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({
    super.key,
  });

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  late FollowingBloc followingBloc;
  @override
  void initState() {
    super.initState();
    followingBloc = FollowingBloc(
        userRepository: context.read<UserRepository>(),
        userBloc: context.read<ubloc.UserBloc>())
      ..add(LoadFollowing());
  }

  @override
  void dispose() {
    followingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 600,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Following',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<FollowingBloc, FollowingState>(
              bloc: followingBloc,
              builder: (context, state) {
                if (state is FollowingLoading) {
                  //Todo:
                  return CircularProgressIndicator();
                }
                if (state is FollowingOperationFailure) {
                  return ElevatedButton(
                      onPressed: () {
                        followingBloc.add(LoadFollowing());
                      },
                      child: Text("Try Again!"));
                }
                if (state is FollowingOperationSuccess) {
                  final List<User> followings = state.followings;
                  return ListView.builder(
                    itemCount: followings.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: profile_avatar(
                          imageUrl: followings[index].profilePicture == ''
                              ? ''
                              : followings[index].profilePicture!,
                          radius: 60,
                          isAsset: followings[index].profilePicture == '',
                        ),
                        title: Text(followings[index].username!),
                        subtitle: Text(followings[index].fullName!),
                        trailing: ElevatedButton(
                          onPressed: () {
                            followingBloc
                                .add(UnfollowUser(followings[index].id!));
                          },
                          child: Text('Unfollow'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      );
                    },
                  );
                }
                return ErrorPage();
              },
            ),
          ),
        ],
      ),
    );
  }
}



// class FollowingScreen extends StatefulWidget {
//   const FollowingScreen({Key? key}) : super(key: key);

//   @override
//   State<FollowingScreen> createState() => _FollowingScreenState();
// }

// class _FollowingScreenState extends State<FollowingScreen> {
//   final List usernames = ["zele", "mike", "leul"];
//   final List names = ["zelalem", "michael", "leul"];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Following'),
//       ),
//       body: ListView.separated(
//         padding: const EdgeInsets.all(20),
//         itemCount: usernames.length, // Set the number of items in the list
//         itemBuilder: (BuildContext context, int index) {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   const CircleAvatar(
//                     maxRadius: 25,
//                     backgroundColor: Colors.black,
//                     child: Icon(Icons.person, color: Colors.white, size: 30),
//                   ),
//                   const SizedBox(width: 20),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         usernames[index],
//                         style: TextStyle(
//                           fontSize: 13,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         names[index],
//                         style: TextStyle(
//                           fontSize: 13,
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: () {},
//                 child: Text('Unfollow'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.green,
//                 ),
//               ),
//             ],
//           );
//         },
//         separatorBuilder: (BuildContext context, int index) {
//           return SizedBox(
//             height: 10,
//           );
//         },
//       ),
//     );
//   }
// }
