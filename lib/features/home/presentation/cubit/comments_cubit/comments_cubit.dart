import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/data/models/comment_model.dart';
import 'package:eyego_task/features/home/data/repo/supabase_repo.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  int offset = 0;
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
        page: offset ~/ 20 + 1,
      );
      result.fold((l) => throw Exception(l), (fetchedComments) {
        if (fetchedComments.length < 20) {
          hasMore = false;
        } else {
          comments.addAll(fetchedComments);
          offset += fetchedComments.length;
        }
      });

      emit(CommentsLoaded(comments: comments));
    } catch (e) {
      emit(CommentsFailure(errorMessage: e.toString()));
    } finally {
      isLoading = false;
    }
  }

  Future<void> addComment(CommentModel comment, ArticleModel article) async {
    try {
      final result = await supabaseRepo.addComment(
        article: article,
        text: comment.text,
      );
      result.fold((l) => throw Exception(l), (addedComment) {
        comments.add(addedComment);
      });

      emit(CommentsLoaded(comments: comments));
    } catch (e) {
      emit(CommentsFailure(errorMessage: e.toString()));
    }
  }
}
