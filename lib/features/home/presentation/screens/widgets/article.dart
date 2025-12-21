import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/article_image.dart';
import 'package:flutter/material.dart';

class Article extends StatelessWidget {
  const Article({
    super.key,
    required this.width,
    required this.height,
    required this.article,
  });

  final double width;
  final double height;
  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: EdgeInsets.zero,

        title: Stack(
          children: [
            ArticleImage(width: width, height: height, article: article),
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
}
