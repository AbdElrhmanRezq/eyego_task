part of 'article_cubit.dart';

@immutable
sealed class ArticleState {}

final class ArticleInitial extends ArticleState {}

final class ArticleSaving extends ArticleState {}

final class ArticleSaved extends ArticleState {}

final class ArticleError extends ArticleState {
  final String message;
  ArticleError(this.message);
}
