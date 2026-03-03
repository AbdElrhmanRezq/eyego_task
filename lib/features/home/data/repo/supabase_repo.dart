import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/errors/failures.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';

abstract class SupabaseRepo {
  Future<Either<Failure, void>> toggleSave(ArticleModel article);
  Future<Either<Failure, bool>> checkSaveStatus(ArticleModel article);

  Future<Either<Failure, List<ArticleModel>>> getSavedArticles({
    int limit = 20,
    int page = 1,
  });

  Future<Either<Failure, int>> getSavesCount(ArticleModel article);
}
