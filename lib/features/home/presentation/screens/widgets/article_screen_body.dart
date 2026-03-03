import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/functions/url_launcher.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/core/widgets/app_button.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/presentation/cubit/article_cubit/article_cubit.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/article_image.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleScreenBody extends StatelessWidget {
  final ArticleModel article;

  const ArticleScreenBody({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(article.name ?? ' ', style: Styles.textStyle20),
          Text(article.title ?? ' ', style: Styles.textStyle16),
          SizedBox(height: 10),
          ArticleImage(width: width, height: height, article: article),
          SizedBox(height: 10),
          article.author != null
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Author: ${article.author}",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : SizedBox(),
          article.author != null ? SizedBox(height: 10) : SizedBox(),

          Text(article.description ?? ' ', style: Styles.textStyle14),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocConsumer<ArticleCubit, ArticleState>(
                builder: (context, state) {
                  if (state is Articletoggling) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ArticleToggled) {
                    return Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<ArticleCubit>().toggleSave(article);
                          },
                          icon: state.isSaved
                              ? Icon(
                                  Icons.bookmark,
                                  color: kMainColor,
                                  size: 36,
                                )
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
        ],
      ),
    );
  }
}
