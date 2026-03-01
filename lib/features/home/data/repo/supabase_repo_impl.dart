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
}
