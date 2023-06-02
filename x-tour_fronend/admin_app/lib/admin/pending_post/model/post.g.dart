// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Posts _$PostsFromJson(Map<String, dynamic> json) => Posts(
      id: json['_id'] as String?,
      story: json['story'] as String,
      description: json['description'] as String,
      likes: json['likes'] as List<dynamic>?,
      creator: json['creator'] == null
          ? null
          : User.fromJson(json['creator'] as Map<String, dynamic>),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PostsToJson(Posts instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  val['story'] = instance.story;
  val['description'] = instance.description;
  writeNotNull('likes', instance.likes);
  writeNotNull('creator', instance.creator?.toJson());
  writeNotNull('images', instance.images);
  writeNotNull('comments', instance.comments);
  return val;
}
