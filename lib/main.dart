import 'package:flutter/material.dart';
import 'package:simple_post_app_bloc/src/features/post/presentation/pages/home_page.dart';

void main() {
  runApp(const PostApp());
}

class PostApp extends StatelessWidget {
  const PostApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xff8B0000),
        colorScheme: const ColorScheme.light().copyWith(
          secondary: Colors.green,
        ),
      ),
      home: const HomePage(),
    );
  }
}
