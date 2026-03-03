import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/data/models/comment_model.dart';
import 'package:eyego_task/features/home/data/repo/supabase_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  TextEditingController commentController = TextEditingController();
  int offset = 0;
  int limit = 5;
  Set<CommentModel> comments = {};
  bool isLoading = false;
  bool hasMore = true;
  final SupabaseRepo supabaseRepo = getIt.get<SupabaseRepo>();
  CommentsCubit() : super(CommentsInitial());
  Future<void> fetchComments({required ArticleModel article}) async {
    if (isLoading || !hasMore) return;
    isLoading = true;
    if (offset == 0) {
      emit(CommentsLoading());
    }
    try {
      final result = await supabaseRepo.fetchComments(
        article: article,
        page: offset ~/ limit + 1,
        limit: limit,
      );
      result.fold((l) => throw Exception(l), (fetchedComments) {
        if (fetchedComments.length < limit) {
          hasMore = false;
        }
        comments.addAll(fetchedComments);
        offset += fetchedComments.length;

        emit(CommentsLoaded(comments: comments));
      });
    } catch (e) {
      emit(CommentsFailure(errorMessage: e.toString()));
    } finally {
      isLoading = false;
    }
  }

  Future<void> addComment(String commentText, ArticleModel article) async {
    emit(CommentSending());
    final result = await supabaseRepo.addComment(
      article: article,
      text: commentText,
    );
    result.fold(
      (l) {
        emit(CommentsFailure(errorMessage: l.toString()));
      },
      (addedComment) async {
        comments.add(addedComment);
        emit(CommentSent(comment: addedComment));
        await Future.delayed(const Duration(seconds: 1));
        commentController.clear();
        emit(CommentsLoaded(comments: comments));
      },
    );
  }
}
