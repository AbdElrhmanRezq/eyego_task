import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/functions/url_launcher.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/core/widgets/app_button.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/presentation/cubit/article_cubit/article_cubit.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/article_image.dart';
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
              AppButton(
                width: width * 0.75,
                text: "Go to article",
                onPressed: () {
                  if (article.url != null) {
                    launchExternalUrl(article.url!);
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("No URL found")));
                  }
                },
              ),
              BlocConsumer<ArticleCubit, ArticleState>(
                builder: (context, state) {
                  if (state is ArticleSaving) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ArticleSaved) {
                    return Icon(Icons.bookmark, color: kMainColor, size: 36);
                  } else {
                    return IconButton(
                      onPressed: () {
                        context.read<ArticleCubit>().saveArticle(article);
                      },
                      icon: Icon(
                        Icons.bookmark_border,
                        color: kMainColor,
                        size: 36,
                      ),
                    );
                  }
                },
                listener: (context, state) {
                  if (state is ArticleSaved) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Article saved successfully")),
                    );
                  } else if (state is ArticleError) {
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
