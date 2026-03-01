import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/errors/failures.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';

abstract class SupabaseRepo {
  Future<Either<Failure, void>> saveArticle(ArticleModel article);
}
