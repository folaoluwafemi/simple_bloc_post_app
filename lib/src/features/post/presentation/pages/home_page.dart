import 'package:bottom_loader/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_post_app_bloc/src/features/post/bloc/post_bloc.dart';
import 'package:simple_post_app_bloc/src/features/post/data/data_provider/post_data_provider.dart';
import 'package:simple_post_app_bloc/src/features/post/data/repository/post_repository.dart';
import 'package:simple_post_app_bloc/src/features/post/presentation/custom_widgets/custom_text.dart';
import 'package:simple_post_app_bloc/src/features/post/presentation/custom_widgets/failure_card.dart';
import 'package:simple_post_app_bloc/src/features/post/presentation/custom_widgets/post_card.dart';
import 'package:simple_post_app_bloc/src/utils/constants/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (BuildContext context) => PostBloc(
        PostRepository(
          postProvider: PostApi(client: MockClient()),
        ),
      )..add(PostFetched()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController? _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    double maxScrollExtent = _scrollController!.position.maxScrollExtent;
    double currentScrollPosition = _scrollController!.offset;
    if (currentScrollPosition >= maxScrollExtent) {
      BottomLoader bottomLoader = BottomLoader(context);
      bottomLoader.style(
        backgroundColor: Colors.grey,
        message: '',
      );
      bottomLoader.display();
      Future<void>.delayed(const Duration(seconds: 1)).then((dynamic value) {
        bottomLoader.close();
      });
      context.read<PostBloc>().add(PostFetched());
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Posts'),
          ),
          body: SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: BlocBuilder<PostBloc, PostState>(
              builder: (BuildContext context, PostState state) {
                if (state.status == PostStatus.initial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.status == PostStatus.failure) {
                  if (state.posts.isEmpty) {
                    return const PostFailureCard();
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const AppText('An error occurred'),
                      backgroundColor: Colors.red.shade900,
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<PostBloc>().add(PostFetched());
                  },
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  child: ListView.builder(
                    itemCount: state.posts.length,
                    controller: _scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return PostCard(
                        post: state.posts[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
