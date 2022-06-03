import 'package:flutter/material.dart';
import 'package:simple_post_app_bloc/src/features/post/presentation/custom_widgets/custom_text.dart';

class PostFailureCard extends StatelessWidget {
  const PostFailureCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AppText(
          'There was an error',
          fontSize: 25,
          color: Colors.red.shade900,
        ),
      ],
    );
  }
}
