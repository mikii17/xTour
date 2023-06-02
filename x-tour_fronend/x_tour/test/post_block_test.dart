import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import "package:x_tour/posts/bloc/load_posts_bloc.dart";
import 'package:x_tour/posts/models/post.dart' as post_model;
import 'package:x_tour/posts/repository/post_repository.dart';
import 'package:x_tour/user/bloc/user_bloc.dart';
import 'package:x_tour/user/models/user.dart';

class MockPostRepository extends Mock implements PostRepository {}

class MockUserBloc extends Mock implements UserBloc {}

final List<post_model.Posts> testPosts = [
  post_model.Posts(
    id: '1',
    story: 'Test story',
    description: 'Test description',
    likes: [],
    creator: null,
    images: [],
    comments: [],
  ),
];
void main() {
  late LoadPostsBloc loadPostsBloc;
  late MockPostRepository mockPostRepository;
  late MockUserBloc mockUserBloc;
  mockPostRepository = MockPostRepository();
  mockUserBloc = MockUserBloc();
  loadPostsBloc = LoadPostsBloc(
    postRepository: mockPostRepository,
    userBloc: mockUserBloc,
  );

  setUp(() {
    mockPostRepository = MockPostRepository();
    mockUserBloc = MockUserBloc();
    loadPostsBloc = LoadPostsBloc(
      postRepository: mockPostRepository,
      userBloc: mockUserBloc,
    );
  });

  tearDown(() {
    loadPostsBloc.close();
  });

  group('LoadPostsBloc', () {
    final List<post_model.Posts> testPosts = [
      post_model.Posts(
        id: '1',
        story: 'Test story',
        description: 'Test description',
        likes: [],
        creator: null,
        images: [],
        comments: [],
      ),
    ];

    test('initial state should be LoadPostsInitial', () {
      expect(loadPostsBloc.state, LoadPostsInitial());
    });

    final expectedStates = [
      PostsLoading(),
      PostsLoaded(posts: testPosts),
    ];

    expectLater(loadPostsBloc.stream, emitsInOrder(expectedStates));

    loadPostsBloc.add(LoadPosts());

    verify(mockPostRepository.getHomepagePosts({"": 1})).called(1);
  });

  test('emits [PostsLoading, PostsLoadMoreFailed] when LoadMore event is added',
      () {
    when(mockPostRepository.getHomepagePosts({"wrwr": 2}))
        .thenThrow(Exception());

    final expectedStates = [
      PostsLoading(),
      PostsLoadMoreFailed(error: Exception("error")),
    ];

    expectLater(loadPostsBloc.stream, emitsInOrder(expectedStates));

    loadPostsBloc.add(LoadMore());

    verify(mockPostRepository.getHomepagePosts({"page": "1"})).called(1);
  });

  test('emits [PostsLoading, PostsLoaded] when LikePost event is added', () {
    when(mockPostRepository.likePost(id: "1")).thenAnswer(
      (_) => Future.value(testPosts.first),
    );

    final expectedStates = [
      PostsLoading(),
      PostsLoaded(posts: [testPosts.first]),
    ];

    expectLater(loadPostsBloc.stream, emitsInOrder(expectedStates));

    loadPostsBloc.add(LikePost(id: '1'));

    verify(mockPostRepository.likePost(id: "1")).called(1);
  });

  // Add more tests for other events and scenarios as needed
}
