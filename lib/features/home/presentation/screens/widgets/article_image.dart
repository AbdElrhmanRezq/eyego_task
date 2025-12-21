import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:flutter/material.dart';

class ArticleImage extends StatelessWidget {
  const ArticleImage({
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Container(
            width: width * 0.9,
            height: height * 0.25,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(article.urlToImage ?? ' '),
                fit: BoxFit.cover, // make sure it covers fully
              ),
            ),
          ),
          Container(
            width: width * 0.9,
            height: height * 0.25,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.65),
                  Colors.black.withValues(alpha: 0.25),
                  Colors.black.withValues(alpha: 0.45),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
