import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/functions/url_launcher.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArticleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ArticleAppBar({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          GoRouter.of(context).pop();
        },
        icon: Icon(Icons.arrow_back_ios_new, color: kMainColor),
      ),
      actions: [
        IconButton(
          onPressed: () {
            if (article.url != null) {
              launchExternalUrl(article.url!);
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("No URL found")));
            }
          },
          icon: Icon(Icons.open_in_new, color: kMainColor),
        ),
        SizedBox(width: 5),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
