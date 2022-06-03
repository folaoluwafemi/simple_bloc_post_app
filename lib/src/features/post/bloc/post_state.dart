part of 'post_bloc.dart';

enum PostStatus {
  success,
  failure,
  initial,
}

class PostState extends Equatable {
  final PostStatus status;
  final bool hasLimitReached;
  final List<PostModel> posts;

  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <PostModel>[],
  }) : hasLimitReached = posts.length == 100;

  PostState copyWith({
    PostStatus? status,
    List<PostModel>? posts,
  }) =>
      PostState(
        status: status ?? this.status,
        posts: posts ?? this.posts,
      );

  @override
  List<Object?> get props => <Object>[status, hasLimitReached, posts];
}
