import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:simple_post_app_bloc/src/features/post/data/data_provider/post_data_provider.dart';
import 'package:simple_post_app_bloc/src/features/post/data/models/post_model.dart';
import 'package:simple_post_app_bloc/src/utils/error/failure.dart';

import '../../../constants/strings.dart';

class MockClient extends Mock implements http.Client {
  MockClient({this.checkingError = false});

  final bool checkingError;

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    if (checkingError) {
      return Future.value(http.Response(
        'limit reached',
        400,
      ));
    }

    http.Response response = http.Response(
      jsonPostsData,
      200,
    );
    return Future.value(response);
  }
}

void main() {
  late PostApi postProvider;
  late PostApi errorProvider;

  setUp(() {
    postProvider = PostApi(client: MockClient());
    errorProvider = PostApi(client: MockClient(checkingError: true));
  });
  tearDownAll(() {});
  test('calling get posts returns a list of posts', () async {
    var testPosts = await postProvider.getPosts();
    expect(testPosts, isA<List<PostModel>>());
  });
  test('calling get posts returns normally', () async {
    expect(() => postProvider.getPosts(), returnsNormally);
  });

  test('calling get posts with n >= 10 throws Failure', () {
    expectLater(
      errorProvider.getPosts(start: 10),
      throwsA(Failure('an error occurred')),
    );
  });
}
