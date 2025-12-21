import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/errors/failures.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';

abstract class NewsRepo {
  Future<Either<Failure, List<ArticleModel>>> getHeadlines({
    int limit = 10,
    int offset = 0,
    String country = 'eg',
    String category = '',
  });
  Future<Either<Failure, List<ArticleModel>>> getEverything({
    int limit = 10,
    int offset = 0,
    String q = '',
    String lang = 'en',
    String sortBy = 'popularity',
  });
}
