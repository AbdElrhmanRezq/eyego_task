part of 'saved_articles_cubit.dart';

@immutable
sealed class SavedArticlesState {}

final class SavedArticlesInitial extends SavedArticlesState {}

final class SavedArticlesLoading extends SavedArticlesState {}

final class SavedArticlesLoaded extends SavedArticlesState {
  final List<ArticleModel> articles;
  final bool hasMore;
  final bool isFetchingMore;
  SavedArticlesLoaded({
    required this.articles,
    required this.hasMore,
    required this.isFetchingMore,
  });
}

final class SavedArticlesError extends SavedArticlesState {
  final String message;
  SavedArticlesError({required this.message});
}
