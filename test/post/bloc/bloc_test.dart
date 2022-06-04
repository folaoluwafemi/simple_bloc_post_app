import 'package:flutter_test/flutter_test.dart';
import 'package:simple_post_app_bloc/src/features/post/bloc/post_bloc.dart';
import 'package:simple_post_app_bloc/src/features/post/data/data_provider/post_data_provider.dart';
import 'package:simple_post_app_bloc/src/features/post/data/repository/post_repository.dart';

import '../data/data_provider/post_provider_test.dart';

void main() {
  late PostBloc postBloc;
  setUp(() {
    postBloc = PostBloc(
      PostRepository(
        postProvider: PostApi(
          client: MockClient(),
        ),
      ),
    );
  });

  group('post bloc initial test', () {
    test(
        'setting up the bloc emits a PostState with PostState.status = PostStatus.initial',
        () async {
      PostState state = postBloc.state;
      await Future.delayed(Duration.zero);
      expect(state.status, PostStatus.initial);
    });
    test(
        'setting up the bloc emits a PostState with PostState.post = empty list',
        () async {
      PostState state = postBloc.state;
      await Future.delayed(Duration.zero);
      expect(state.posts.isEmpty, true);
    });
    test(
        'setting up the bloc emits a PostState with PostState.hasReachedLimit is false',
        () async {
      PostState state = postBloc.state;
      await Future.delayed(Duration.zero);
      expect(state.hasLimitReached, false);
    });
  });

  group('fetch post event test', () {
    test(
      'when post event is added bloc should emit post state with a non-empty list of post',
      () async {
        postBloc.add(PostFetched());
        await Future.delayed(Duration.zero);
        PostState state = postBloc.state;
        expect(state.posts.isNotEmpty, true);
      },
    );

    test(
      'when post event is added bloc should emit post state with a list of post with length 10',
      () async {

        postBloc.add(PostFetched());
        await Future.delayed(Duration.zero);
        PostState state = postBloc.state;
        expect(state.posts.length, 10);
      },
    );

    test(
      'when post event is added bloc should emit post state with a status of success',
      () async {
        postBloc.add(PostFetched());
        await Future.delayed(Duration.zero);
        PostState state = postBloc.state;
        expect(state.status, PostStatus.success);
      },
    );
  });

  group('when reload is called', () {
    setUp(() {
      postBloc.add(PostFetched());
    });
    test(
      'when post event is added bloc should emit post state with a non-empty list of post',
      () async {
        postBloc.add(PostFetched());
        await Future.delayed(Duration.zero);
        PostState state = postBloc.state;
        expect(state.posts.isNotEmpty, true);
      },
    );

    test(
      'when post event is added bloc should emit post state with a list of post with lenght 10',
      () async {
        postBloc.add(PostFetched());
        await Future.delayed(Duration.zero);
        PostState state = postBloc.state;
        expect(state.posts.length, 20);
      },
    );

    test(
      'when post event is added bloc should emit post state with a status of success',
      () async {
        postBloc.add(PostFetched());
        await Future.delayed(Duration.zero);
        PostState state = postBloc.state;
        expect(state.status, PostStatus.success);
      },
    );
  });

  group('test error', () {
    late PostBloc errorPostBloc;
    setUp(() {
      errorPostBloc = PostBloc(
        PostRepository(
          postProvider: PostApi(
            client: MockClient(checkingError: true),
          ),
        ),
      );
    });

    test(
      'when post event is added bloc should emit post state with a status of success',
      () async {
        errorPostBloc.add(PostFetched());
        await Future.delayed(Duration.zero);
        PostState state = errorPostBloc.state;
        expect(state.status, PostStatus.failure);
      },
    );
  });
}
