part of 'article_cubit.dart';

@immutable
sealed class ArticleState {}

final class ArticleInitial extends ArticleState {}

final class Articletoggling extends ArticleState {}

final class ArticleToggled extends ArticleState {
  bool isSaved;
  int saveCount;
  int commentsCount;
  ArticleToggled({
    required this.isSaved,
    this.saveCount = 0,
    this.commentsCount = 0,
  });
}

final class ArticleError extends ArticleState {
  final String message;
  ArticleError(this.message);
}
