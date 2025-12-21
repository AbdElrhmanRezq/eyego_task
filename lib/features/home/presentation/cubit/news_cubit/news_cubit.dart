import 'package:bloc/bloc.dart';
import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/data/repo/news_repo.dart';
import 'package:eyego_task/features/home/data/repo/news_repo_impl.dart';
import 'package:meta/meta.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  final NewsRepo newsRepo = getIt.get<NewsRepoImpl>();

  final int limit = 10;
  int page = 1;

  final List<ArticleModel> articles = [];
  bool isFetchingMore = false;
  bool hasMore = true;

  Future<void> fetchHeadlines({bool loadMore = false}) async {
    if (isFetchingMore) return;
    if (loadMore && !hasMore) return;

    isFetchingMore = true;

    if (!loadMore && articles.isEmpty) {
      emit(NewsLoading());
      page = 1;
      articles.clear();
      hasMore = true;
    }

    final result = await newsRepo.getHeadlines(page: page);

    result.fold(
      (failure) {
        isFetchingMore = false;
        emit(NewsError(failure.message));
      },
      (newArticles) {
        articles.addAll(newArticles);

        hasMore = newArticles.length == limit;
        page++;

        emit(
          NewsLoaded(
            articles: [...articles],
            hasMore: hasMore,
            isLoadingMore: isFetchingMore,
          ),
        );
        isFetchingMore = false;
      },
    );
  }
}
