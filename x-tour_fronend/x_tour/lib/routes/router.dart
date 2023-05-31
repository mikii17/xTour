import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_tour/routes/route_constants.dart';
import 'package:x_tour/screens/othersProfileScreen.dart';
import '../screens/editProfileScreen.dart';
import '../screens/screens.dart';
import '../theme/xTour_theme.dart';

final GlobalKey<NavigatorState> _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionNavigationKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionKey');

class AppRoute extends StatelessWidget {
  AppRoute({super.key});

  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigationKey,
    initialLocation: '/',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeScreen(navigationShell: navigationShell);
        } ,
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _sectionNavigationKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/',
                builder:(context, state) {
                  return PostListScreen();
                },

                routes: <RouteBase>[
                  GoRoute(
                    path: 'othersProfile',
                    builder: (context, state) {
                      return OtherProfileScreen();
                    },
                  ),
                   GoRoute(
                      path: 'comments',
                      builder: (context, state) {
                        return XtourCommentSection();
                      },
                  ),
                ]
              )
            ]
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                  path: '/search',
                  builder: (context, state) {
                    return SearchScreen();
                  },
                  routes: <RouteBase>[
                    // GoRoute(
                    //   path: 'othersProfile',
                    //   builder: (context, state) {
                    //     return OtherProfileScreen();
                    //   },
                    // ),
                    // GoRoute(
                    //   path: 'comments',
                    //   builder: (context, state) {
                    //     return XtourCommentSection();
                    //   },
                    // ),
              ])
          ]),
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: '/journal',
              builder: (context, state) {
                return JournalListScreen();
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'othersProfile',
                  builder: (context, state) {
                    return OtherProfileScreen();
                  },
                ),
              ])
          ]),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                  path: '/profile',
                  builder: (context, state) {
                    return ProfileScreen();
                  },
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'editProfile',
                      builder: (context, state) {
                        return EditProfileScreen();
                      },
                    ),
                    GoRoute(
                      path: 'editPendingPost',
                      builder: (context, state) {
                        return EditPendingPostScreen();
                      },
                    ),
                    GoRoute(
                        path: 'editPendingJournal',
                        builder: (context, state) {
                          return EditPendingJournalScreen();
                        },
                      ),
                    GoRoute(
                        path: 'follower',
                        builder: (context, state) {
                          return FollowerScreen();
                        },
                      ),
                      GoRoute(
                        path: 'following',
                        builder: (context, state) {
                          return FollowingScreen();
                        },
                      )
                  ])
            ]),
            
              StatefulShellBranch(routes: <RouteBase>[
                GoRoute(
                  path: '/createPost',
                  builder: (context, state) {
                    return PostListScreen();
                  },
                )
              ]),
              StatefulShellBranch(routes: <RouteBase>[
                GoRoute(
                  path: '/createJournal',
                  builder: (context, state) {
                    return PostListScreen();
                  },
                )
              ]),
        ]
        )
    ]
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: XTourTheme().dark(),
      routerConfig: _router,
    )
    ;
  }
}

