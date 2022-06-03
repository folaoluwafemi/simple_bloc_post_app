import 'package:simple_post_app_bloc/src/features/post/data/models/post_model.dart';

abstract class PostDataProviderInterface {
  Future<List<PostModel>> getPosts({int start = 0});
}
