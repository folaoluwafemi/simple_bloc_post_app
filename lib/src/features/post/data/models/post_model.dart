import 'package:equatable/equatable.dart';
import 'package:simple_post_app_bloc/src/utils/constants/strings.dart';

part 'post_model_factory.dart';

class PostModel extends Equatable {
  final int postId;
  final String title;
  final String body;
  final int userId;

  const PostModel({
    required this.postId,
    required this.title,
    required this.body,
    required this.userId,
  });

  @override
  List<Object?> get props => [postId, title, body, userId];
}
