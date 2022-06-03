import 'package:simple_post_app_bloc/src/features/post/data/data_provider/interface/post_data_provider_interface.dart';
import 'package:simple_post_app_bloc/src/features/post/data/models/post_model.dart';

class PostRepository {
  final PostDataProviderInterface _postProvider;

  PostRepository({required PostDataProviderInterface postProvider})
      : _postProvider = postProvider;

  Future<List<PostModel>> getPosts(int n) async {
    if (n < 1) {
      List<PostModel> posts = await _postProvider.getPosts();
      return posts;
    }
    int limit = n * 10;
    int start = limit - 10;
    List<PostModel> posts = await _postProvider.getPosts(start: start);
    return posts;
  }
}
