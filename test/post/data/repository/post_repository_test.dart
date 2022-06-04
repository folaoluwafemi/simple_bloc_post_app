import 'package:flutter_test/flutter_test.dart';
import 'package:simple_post_app_bloc/src/features/post/data/data_provider/post_data_provider.dart';
import 'package:simple_post_app_bloc/src/features/post/data/models/post_model.dart';
import 'package:simple_post_app_bloc/src/features/post/data/repository/post_repository.dart';
import 'package:simple_post_app_bloc/src/utils/error/failure.dart';

import '../data_provider/post_provider_test.dart';

void main() {
  late PostRepository postRepo;

  setUpAll(() {
    postRepo = PostRepository(
      postProvider: PostApi(
        client: MockClient(),
      ),
    );
  });

  group('get post test', () {
    test('when get posts is called should return a list of posts ', () async {
      List<PostModel> postList = await postRepo.getPosts(0);
      expectLater(postList, isA<List<PostModel>>());
    });
    test(
        'when get posts is called with n = 0 it should return a 10 list of posts',
        () async {
      List<PostModel> postList = await postRepo.getPosts(0);
      expectLater(postList.length, 10);
    });
    test(
        'when get posts is called with n = 1 it should return only 10 list of posts',
        () async {
      List<PostModel> postList = await postRepo.getPosts(1);
      expectLater(postList.length, 10);
    });
    test(
        'when get posts is called with n = 10 it should catch a failure limit reached error',
        () async {
      PostRepository testPostRepo = PostRepository(
        postProvider: PostApi(
          client: MockClient(checkingError: true),
        ),
      );

      expectLater(() async => await testPostRepo.getPosts(10), throwsA(Failure('an error occurred')));
      // throwsA(Exception('limit reached'));
    });
  });
}
