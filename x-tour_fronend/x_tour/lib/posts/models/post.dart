// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../user/models/user.dart';

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

  factory Posts.fromMap(Map<String, dynamic> json) => Posts(
        id: json['_id'] as String?,
        story: json['story'] as String,
        description: json['description'] as String,
        likes: jsonDecode(json['likes']) as List<dynamic>?,
        creator: json['creator'] == null
            ? null
            : User.fromJson(
                jsonDecode(json['creator']) as Map<String, dynamic>),
        images: (jsonDecode(json['images']) as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        comments: (jsonDecode(json['comments']) as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
      );

  Map<String, dynamic> toMap() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('_id', id);
    val['story'] = story;
    val['description'] = description;
    writeNotNull('likes', jsonEncode(likes));
    writeNotNull('creator', jsonEncode(creator?.toJson()));
    writeNotNull('images', jsonEncode(images));
    writeNotNull('comments', jsonEncode(comments));
    return val;
  }

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
