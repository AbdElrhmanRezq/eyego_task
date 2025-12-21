import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/features/home/presentation/cubit/news_cubit/news_cubit.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/article_image.dart';
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

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,

                      title: Stack(
                        children: [
                          ArticleImage(
                            width: width,
                            height: height,
                            article: article,
                          ),
                          Positioned(
                            left: 8,
                            bottom: 4,
                            child: SizedBox(
                              width: width * .85,
                              child: Text(
                                article.title ?? '',
                                style: Styles.textStyle16.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 8,
                            top: 4,
                            child: SizedBox(
                              width: width * .85,
                              child: Text(
                                article.source?.name ?? '',
                                style: Styles.textStyle16.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 4,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.open_in_new, color: kMainColor),
                            ),
                          ),
                        ],
                      ),
                    ),
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
