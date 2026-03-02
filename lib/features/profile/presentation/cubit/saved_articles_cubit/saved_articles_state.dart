part of 'saved_articles_cubit.dart';

@immutable
sealed class SavedArticlesState {}

final class SavedArticlesInitial extends SavedArticlesState {}

final class SavedArticlesLoading extends SavedArticlesState {}

final class SavedArticlesLoaded extends SavedArticlesState {
  final List<ArticleModel> articles;
  bool hasMore;
  bool isFetchingMore;
  SavedArticlesLoaded({
    required this.articles,
    this.hasMore = true,
    this.isFetchingMore = false,
  });
}

final class SavedArticlesError extends SavedArticlesState {
  final String message;
  SavedArticlesError({required this.message});
}
