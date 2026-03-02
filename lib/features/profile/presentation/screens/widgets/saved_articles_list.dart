import 'package:eyego_task/features/home/presentation/screens/widgets/article.dart';
import 'package:eyego_task/features/profile/presentation/cubit/saved_articles_cubit/saved_articles_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedArticlesList extends StatelessWidget {
  const SavedArticlesList({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),

      sliver: BlocBuilder<SavedArticlesCubit, SavedArticlesState>(
        builder: (context, state) {
          if (state is SavedArticlesLoading) {
            return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is SavedArticlesError) {
            return SliverToBoxAdapter(
              child: Center(child: Text(state.message)),
            );
          } else if (state is SavedArticlesLoaded) {
            if (state.articles.isEmpty) {
              return const SliverToBoxAdapter(
                child: Center(child: Text("No saved articles")),
              );
            }
            return SliverList.builder(
              itemCount: state.articles.length + 1,
              itemBuilder: (context, index) {
                if (index < state.articles.length) {
                  final article = state.articles[index];

                  return Article(
                    width: width,
                    height: height,
                    article: article,
                  );
                } else {
                  if (state.hasMore) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const SizedBox();
                  }
                }
              },
            );
          } else {
            return const SliverToBoxAdapter();
          }
        },
      ),
    );
  }
}
