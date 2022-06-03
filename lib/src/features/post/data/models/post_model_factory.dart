part of 'post_model.dart';

class PostModelFactory {
  static PostModel postFromMap(Map<String, dynamic> map) {
    return PostModel(
      postId: map[postIdModelKey],
      title: map[postTitleModelKey],
      body: map[postBodyModelKey],
      userId: map[postUserIdModelKey],
    );
  }
}
