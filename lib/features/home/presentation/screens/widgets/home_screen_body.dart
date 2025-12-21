import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/presentation/cubit/news_cubit/news_cubit.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/article_image.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/explore_bar.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/news_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().fetchHeadlines();

    _scrollController.addListener(() {
      final cubit = context.read<NewsCubit>();
      final state = cubit.state;
      if (state is NewsLoaded &&
          state.hasMore &&
          !cubit.isFetchingMore &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200) {
        cubit.fetchHeadlines(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExploreBar(),
                Divider(thickness: 2, color: kMainColor),
              ],
            ),
          ),
          NewsList(width: width, height: height),
        ],
      ),
    );
  }
}
