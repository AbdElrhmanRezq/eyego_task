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
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index < state.articles.length) {
                  final article = state.articles[index];

                  return Article(
                    width: width,
                    height: height,
                    article: article,
                  );
                }

                if (state.isLoadingMore && index == state.articles.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return const SizedBox.shrink();
              },
              childCount: state.articles.length + (state.isLoadingMore ? 1 : 0),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
