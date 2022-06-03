import 'package:flutter/cupertino.dart';
import 'package:simple_post_app_bloc/src/features/post/data/models/post_model.dart';
import 'package:simple_post_app_bloc/src/features/post/presentation/custom_widgets/custom_text.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: AppText(
              '${post.postId}',
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                post.title,
                fontSize: 15,
                weight: FontWeight.w600,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
              ),
              AppText(
                post.body,
                fontSize: 15,
                weight: FontWeight.w400,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
