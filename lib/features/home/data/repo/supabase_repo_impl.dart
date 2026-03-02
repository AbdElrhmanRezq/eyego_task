import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/errors/failures.dart';
import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/data/repo/supabase_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRepoImpl implements SupabaseRepo {
  @override
  Future<Either<Failure, void>> saveArticle(ArticleModel article) async {
    final SupabaseClient supabase = getIt.get<SupabaseClient>();
    try {
      final response = await supabase
          .from('saved_articles')
          .insert(article.toJson())
          .maybeSingle();
      if (response == null) {
        return Left(DataFailure("Failed to save article"));
      } else {
        return const Right(null);
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
      final response = await supabase
          .from('saved_articles')
          .select()
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
}
