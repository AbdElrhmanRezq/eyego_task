part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class NewsLoading extends NewsState {}

final class NewsLoaded extends NewsState {
  final List<ArticleModel> articles;
  final bool hasMore;
  final bool isLoadingMore;
  NewsLoaded({
    required this.articles,
    required this.hasMore,
    this.isLoadingMore = false,
  });
}

final class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
}
