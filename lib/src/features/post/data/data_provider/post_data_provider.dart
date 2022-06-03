import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:http/http.dart';
import 'package:simple_post_app_bloc/src/features/post/data/data_provider/interface/post_data_provider_interface.dart';
import 'package:simple_post_app_bloc/src/features/post/data/models/post_model.dart';
import 'package:simple_post_app_bloc/src/utils/error/failure.dart';

class PostApi implements PostDataProviderInterface {
  final Client _client;

  PostApi({required Client client}) : _client = client;

  static String urlHost = 'jsonplaceholder.typicode.com';
  static String urlPath = '/posts';

  Uri _getUri({String start = '0', String limit = '10'}) {
    return Uri(
      host: urlHost,
      path: urlPath,
      queryParameters: <String, String>{
        '_start': start,
        '_limit': limit,
      },
    );
  }

  Future<String> _makeRequest(Uri uri) async {
    try {
      Response response = await _client.get(uri);
      if (response.statusCode != 200) {
        throw Failure('an error occurred');
      }
      return response.body;
    } on HttpException {
      throw Failure('There was an http exception');
    } on SocketException {
      throw Failure('There was socket exception');
    } catch (e) {
      dev.log(e.toString());
      return Future<String>.error(Failure(e.toString()), StackTrace.current);
    }
  }

  List<PostModel> _convertJsonToPosts(List<dynamic> json) {
    List<PostModel> posts = <PostModel>[];
    for (Map<String, dynamic> map in json) {
      PostModel post = PostModelFactory.postFromMap(map);
      posts.add(post);
    }
    return posts;
  }

  @override
  Future<List<PostModel>> getPosts({int start = 0}) async {
    Uri url = _getUri(start: '$start');
    String rawResponseData = await _makeRequest(url);
    List<dynamic> jsonData = jsonDecode(rawResponseData);
    return _convertJsonToPosts(jsonData);
  }
}
