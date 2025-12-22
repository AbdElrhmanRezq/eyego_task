import 'package:eyego_task/core/widgets/simple_app_bar.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/article_screen_body.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {
  final ArticleModel article;
  const ArticleScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(),
      body: ArticleScreenBody(article: article),
    );
  }
}
