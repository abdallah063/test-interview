
import 'package:test_interview/model/api_model/post_model.dart';
import 'package:test_interview/model/api_model/profile_model.dart';

import 'comment_model.dart';

class APIResponse {
  List<PostModel> posts;
  List<CommentModel> comments;
  ProfileModel profile;

  APIResponse({required this.posts, required this.comments, required this.profile});

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    List<PostModel> posts = (json['posts'] as List)
        .map((postJson) => PostModel.fromJson(postJson))
        .toList();

    List<CommentModel> comments = (json['comments'] as List)
        .map((commentJson) => CommentModel.fromJson(commentJson))
        .toList();

    ProfileModel profile = ProfileModel.fromJson(json['profile']);

    return APIResponse(posts: posts, comments: comments, profile: profile);
  }
}

