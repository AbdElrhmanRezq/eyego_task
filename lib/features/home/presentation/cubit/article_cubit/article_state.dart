part of 'article_cubit.dart';

@immutable
sealed class ArticleState {}

final class ArticleInitial extends ArticleState {}

final class Articletoggling extends ArticleState {}

final class ArticleToggled extends ArticleState {
  bool isSaved;
  ArticleToggled({required this.isSaved});
}

final class ArticleError extends ArticleState {
  final String message;
  ArticleError(this.message);
}
