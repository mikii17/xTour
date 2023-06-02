part of 'searchpost_bloc.dart';

abstract class SearchpostEvent extends Equatable {
  const SearchpostEvent();

  @override
  List<Object> get props => [];
}

class SearchPost extends SearchpostEvent {
  final String search;
  final int limit;
  final int page;

  const SearchPost({this.search = '', this.limit = 20, this.page = 1});

  @override
  List<Object> get props => [search, limit, page];
}

class LikePost extends SearchpostEvent {
  final String id;
  const LikePost({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class UnlikePost extends SearchpostEvent {
  final String id;
  const UnlikePost({required this.id});

  @override
  List<Object> get props => [id];
}
