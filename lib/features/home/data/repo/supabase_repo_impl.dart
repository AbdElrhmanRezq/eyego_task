import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/errors/failures.dart';
import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/data/models/comment_model.dart';
import 'package:eyego_task/features/home/data/repo/supabase_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRepoImpl implements SupabaseRepo {
  @override
  Future<Either<Failure, void>> toggleSave(ArticleModel article) async {
    final SupabaseClient supabase = getIt.get<SupabaseClient>();
    try {
      final bool isSaved = await checkSaveStatus(
        article,
      ).then((result) => result.fold((failure) => false, (status) => status));
      if (isSaved) {
        final response = await supabase
            .from('saved_articles')
            .delete()
            .eq('url', article.url as String)
            .eq('u_id', supabase.auth.currentUser?.id as String);
        if (response == null) {
          return Left(DataFailure("Failed to unsave article"));
        } else {
          return const Right(null);
        }
      } else {
        final response = await supabase
            .from('saved_articles')
            .insert(article.toJson())
            .maybeSingle();
        if (response == null) {
          return Left(DataFailure("Failed to save article"));
        } else {
          return const Right(null);
        }
      }
    } on DataFailure catch (e) {
      return Left(DataFailure.fromException(e.message));
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ArticleModel>>> getSavedArticles({
    int limit = 20,
    int page = 1,
  }) async {
    try {
      final SupabaseClient supabase = getIt.get<SupabaseClient>();
      final String uId = supabase.auth.currentUser?.id as String;
      final response = await supabase
          .from('saved_articles')
          .select()
          .eq("u_id", uId)
          .range((page - 1) * limit, page * limit - 1);
      if (response == null) {
        return left(DataFailure("Failed to fetch saved articles"));
      } else {
        List<ArticleModel> articles = (response as List)
            .map((articleJson) => ArticleModel.fromJson(articleJson))
            .toList();
        return right(articles);
      }
    } on DataFailure catch (e) {
      return left(DataFailure.fromException(e.message));
    } catch (e) {
      return left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkSaveStatus(ArticleModel article) async {
    try {
      final SupabaseClient supabase = getIt.get<SupabaseClient>();

      final userId = supabase.auth.currentUser?.id;

      if (userId == null || article.url == null) {
        return const Right(false);
      }
      final response = await supabase
          .from('saved_articles')
          .select()
          .eq('u_id', userId)
          .eq('url', article.url!)
          .maybeSingle();
      print(response);
      return Right(response != null);
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getSavesCount(ArticleModel article) async {
    try {
      final SupabaseClient supabase = getIt.get<SupabaseClient>();
      return supabase
          .from('saved_articles')
          .select('a_id')
          .eq('url', article.url as String)
          .count(CountOption.exact)
          .then((response) {
            print(response);
            if (response == null) {
              return Left(DataFailure("Failed to fetch saves count"));
            } else {
              final count = response.count ?? 0;
              return Right(count);
            }
          });
    } on DataFailure catch (e) {
      return Left(DataFailure.fromException(e.message));
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getComments({
    required ArticleModel article,
    int limit = 20,
    int page = 1,
  }) async {
    try {
      final SupabaseClient supabase = getIt.get<SupabaseClient>();
      final response = await supabase
          .from('comments')
          .select()
          .eq('url', article.url as String)
          .range((page - 1) * limit, page * limit - 1);
      if (response == null) {
        return Left(DataFailure("Failed to fetch comments"));
      }
      List<CommentModel> comments = (response as List)
          .map((commentJson) => CommentModel.fromJson(commentJson))
          .toList();
      return Right(comments);
    } on DataFailure catch (e) {
      return Left(DataFailure.fromException(e.message));
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentModel>> addComment({
    required ArticleModel article,
    required String text,
  }) async {
    try {
      final SupabaseClient supabase = getIt.get<SupabaseClient>();
      final userId = supabase.auth.currentUser?.id;
      if (userId == null || article.url == null) {
        return Left(
          DataFailure("User not authenticated or article URL missing"),
        );
      }
      final response = await supabase.from('comments').insert({
        'u_id': userId,
        'url': article.url,
        'text': text,
      }).maybeSingle();
      if (response == null) {
        return Left(DataFailure("Failed to add comment"));
      }
      final comment = CommentModel.fromJson(response);
      return Right(comment);
    } on DataFailure catch (e) {
      return Left(DataFailure.fromException(e.message));
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }
}
