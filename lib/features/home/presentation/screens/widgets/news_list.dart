import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/features/home/presentation/cubit/news_cubit/news_cubit.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        final articles = (context).read<NewsCubit>().articles;
        if (state is NewsLoading) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is NewsError) {
          return SliverFillRemaining(
            child: Center(
              child: Text(state.message, style: Styles.textStyle20),
            ),
          );
        }

        if (state is NewsLoaded) {
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index < articles.length) {
                final article = articles[index];

                return Article(width: width, height: height, article: article);
              } else {
                return Center(child: CircularProgressIndicator());
              }

              return const SizedBox.shrink();
            }, childCount: articles.length + 1),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
