import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/functions/time_ago.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/features/home/presentation/cubit/comments_cubit/comments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Comments extends StatelessWidget {
  const Comments({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        if (state is CommentsLoading && state is! CommentsInitial) {
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator(color: kMainColor)),
          );
        } else if (state is CommentsFailure) {
          return SliverToBoxAdapter(
            child: Center(child: Text('Failed to load comments')),
          );
        } else {
          return SliverList.builder(
            itemCount: context.read<CommentsCubit>().comments.length,
            itemBuilder: (context, index) {
              final comment = context.read<CommentsCubit>().comments.elementAt(
                index,
              );
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comment.userId, style: Styles.textStyle16),
                          const SizedBox(height: 4),
                          Text(comment.text, style: Styles.textStyle14),
                          const SizedBox(height: 4),
                          Text(
                            timeAgo(comment.createdAt ?? DateTime.now()),
                            style: Styles.textStyle14.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
