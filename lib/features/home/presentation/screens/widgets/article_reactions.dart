import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/features/home/presentation/cubit/article_cubit/article_cubit.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/article_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleReactions extends StatelessWidget {
  const ArticleReactions({super.key, required this.widget});

  final ArticleScreenBody widget;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocConsumer<ArticleCubit, ArticleState>(
            builder: (context, state) {
              if (state is Articletoggling) {
                return Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: CircularProgressIndicator(),
                );
              } else if (state is ArticleToggled) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<ArticleCubit>().toggleSave(widget.article);
                      },
                      icon: Icon(Icons.comment, color: kMainColor, size: 36),
                    ),
                    Text(
                      "${state.commentsCount}",
                      style: Styles.textStyle18.copyWith(color: kMainColor),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<ArticleCubit>().toggleSave(widget.article);
                      },
                      icon: state.isSaved
                          ? Icon(Icons.bookmark, color: kMainColor, size: 36)
                          : Icon(
                              Icons.bookmark_border,
                              color: kMainColor,
                              size: 36,
                            ),
                    ),
                    Text(
                      "${state.saveCount}",
                      style: Styles.textStyle18.copyWith(color: kMainColor),
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            },
            listener: (context, state) {
              if (state is ArticleError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ],
      ),
    );
  }
}
