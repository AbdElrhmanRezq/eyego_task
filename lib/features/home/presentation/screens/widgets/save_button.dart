import 'package:eyego_task/core/utils/functions/url_launcher.dart';
import 'package:eyego_task/core/widgets/app_button.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.width, required this.article});

  final double width;
  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return AppButton(
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
    );
  }
}
