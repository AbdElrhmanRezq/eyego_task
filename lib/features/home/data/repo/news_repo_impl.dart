import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eyego_task/core/errors/failures.dart';
import 'package:eyego_task/core/utils/api_service.dart';
import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/data/repo/news_repo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsRepoImpl implements NewsRepo {
  final String apiKey = dotenv.env['API_KEY']!;
  final ApiService apiService = getIt.get<ApiService>();
  @override
  Future<Either<Failure, List<ArticleModel>>> getEverything({
    int limit = 10,
    int page = 1,
    String q = '',
    String lang = 'en',
    String sortBy = 'relevancy',
  }) async {
    try {
      String endpoint =
          'everything?q=$q&language=$lang&sortBy=$sortBy&pageSize=$limit&page=$page&searchIn=title&apiKey=$apiKey';
      final Map<String, dynamic> response = await apiService.get(
        endpoint: endpoint,
      );

      final articlesJson = response['articles'] as List<dynamic>;
      final List<ArticleModel> articles = articlesJson
          .map((articleJson) => ArticleModel.fromJson(articleJson))
          .toList();
      return right(articles);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ArticleModel>>> getHeadlines({
    int limit = 10,
    int page = 1,
    String country = 'us',
    String category = 'general',
  }) async {
    try {
      String endpoint =
          'top-headlines?country=$country&category=$category&pageSize=$limit&page=$page&apiKey=$apiKey';
      final Map<String, dynamic> response = await apiService.get(
        endpoint: endpoint,
      );
      final articlesJson = response['articles'] as List<dynamic>;
      final List<ArticleModel> articles = articlesJson
          .map((articleJson) => ArticleModel.fromJson(articleJson))
          .toList();
      return right(articles);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
