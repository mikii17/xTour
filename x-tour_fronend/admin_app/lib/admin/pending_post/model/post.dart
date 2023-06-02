import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:x_tour/admin/user/model/user.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class Posts extends Equatable {
  @JsonKey(name: "_id", includeIfNull: false)
  String? id;

  String story;

  String description;

  @JsonKey(includeIfNull: false)
  List<dynamic>? likes;

  @JsonKey(includeIfNull: false)
  User? creator;

  @JsonKey(includeIfNull: false)
  List<String>? images;

  @JsonKey(includeIfNull: false)
  List<String>? comments;

  Posts(
      {this.id,
      required this.story,
      required this.description,
      this.likes,
      this.creator,
      this.images,
      this.comments});

  factory Posts.fromJson(Map<String, dynamic> json) => _$PostsFromJson(json);
  Map<String, dynamic> toJson() => _$PostsToJson(this);

  Posts copyWith({story, description, likes, creator, images, comments}) {
    return Posts(
        id: id,
        story: story ?? this.story,
        description: description ?? this.description,
        likes: likes ?? this.likes,
        creator: creator ?? this.creator,
        images: images ?? this.images,
        comments: comments ?? this.comments);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  List<Object?> get props => [id, story, description, likes, creator, images];
}
