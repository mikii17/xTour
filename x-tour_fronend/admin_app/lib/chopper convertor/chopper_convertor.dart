import 'dart:async';
import 'dart:html';

import 'package:chopper/chopper.dart';
import 'dart:convert';


import '../admin/pending_journal/model/journal.dart';
import '../admin/pending_post/model/post.dart';
import '../admin/user/model/user.dart';


class ChopperConvetor extends JsonConverter {
  final Map<Type, Function> jsonToTypeFactoryMap = {
    Journal: Journal.fromJson,
    Posts: Posts.fromJson,
    User: User.fromJson,
   
  };

  ChopperConvetor();

  @override
  Request convertRequest(Request request) {
    request.copyWith(
      body: request.body.toJson() as Map<String, dynamic>,
    );
    return super.convertRequest(request);
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return response.copyWith(
      body: fromJsonData<BodyType, InnerType>(
          response.body, jsonToTypeFactoryMap[InnerType]!),
    );
  }

  T fromJsonData<T, InnerType>(String jsonData, Function jsonParser) {
    var jsonMap = json.decode(jsonData);

    if (jsonMap is List) {
      return jsonMap
          .map((item) => jsonParser(item as Map<String, dynamic>) as InnerType)
          .toList() as T;
    }

    return jsonParser(jsonMap);
  }
}
