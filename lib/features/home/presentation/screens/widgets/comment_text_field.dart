import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/presentation/cubit/article_cubit/article_cubit.dart';
import 'package:eyego_task/features/home/presentation/cubit/comments_cubit/comments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CommentTextField extends StatelessWidget {
  const CommentTextField({super.key, required this.article});

  final ArticleModel article;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            maxLines: 3,
            minLines: 1,
            cursorColor: kMainColor,
            style: Styles.textStyle16,
            textAlignVertical: TextAlignVertical.top,
            controller: context.read<CommentsCubit>().commentController,
            decoration: InputDecoration(
              hintText: "Add a comment...",
              suffixIcon: IconButton(
                onPressed: state is CommentSending
                    ? null
                    : () {
                        context.read<CommentsCubit>().addComment(
                          context.read<CommentsCubit>().commentController.text,
                          article,
                        );
                        context.read<ArticleCubit>().getCommentsCount(article);
                      },
                icon: SentIcon(state: state),
              ),
              border: InputBorder.none,
            ),
          ),
        );
      },
    );
  }
}

class SentIcon extends StatelessWidget {
  final CommentsState state;
  const SentIcon({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is CommentSending) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2, color: kMainColor),
      );
    } else if (state is CommentsFailure) {
      final failure = state as CommentsFailure;
      print(failure.errorMessage);
      return const Icon(Icons.error, color: Colors.red);
    } else if (state is CommentSent) {
      return const Icon(Icons.check, color: Colors.green);
    }
    return Icon(Icons.send, color: kMainColor);
  }
}
