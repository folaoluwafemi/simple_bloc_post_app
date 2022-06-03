import 'dart:async';
import 'dart:developer' as dev;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_post_app_bloc/src/features/post/data/models/post_model.dart';
import 'package:simple_post_app_bloc/src/features/post/data/repository/post_repository.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;

  PostBloc(PostRepository postRepo)
      : _postRepository = postRepo,
        super(PostState()) {
    on<PostFetched>(_handlePostFetched);
  }

  Future<List<PostModel>> _fetchPostsFromApi() async {
    List<PostModel> posts = <PostModel>[];
    if (state.posts.isEmpty) {
      dev.log('post is empty');
      posts.addAll(await _postRepository.getPosts(0));
      dev.log(posts.length.toString());
      return posts;
    }
    if (state.posts.isNotEmpty) {
      int n = (state.posts.length + 10) ~/ 10;
      posts.addAll(state.posts);
      posts.addAll((await _postRepository.getPosts(n)));
    }
    return posts;
  }

  Future<void> _handlePostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    try {
      if (!state.hasLimitReached) {
        List<PostModel> posts = await _fetchPostsFromApi();
        emit(state.copyWith(
          posts: posts,
          status: PostStatus.success,
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
      dev.log(e.toString());
    }
  }
}
