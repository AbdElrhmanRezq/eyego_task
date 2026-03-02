import 'package:bloc/bloc.dart';
import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/data/repo/supabase_repo.dart';
import 'package:meta/meta.dart';

part 'saved_articles_state.dart';

class SavedArticlesCubit extends Cubit<SavedArticlesState> {
  final SupabaseRepo supabaseRepo = getIt.get<SupabaseRepo>();
  int page = 1;
  int limit = 20;
  bool isFetchingMore = false;
  bool hasMore = true;
  final List<ArticleModel> savedArticles = [];
  SavedArticlesCubit() : super(SavedArticlesInitial());
  Future<void> getSavedArticles() async {
    if (isFetchingMore) return;
    isFetchingMore = true;
    //emit(SavedArticlesLoading());
    final result = await supabaseRepo.getSavedArticles(
      limit: limit,
      page: page,
    );
    result.fold(
      (failure) {
        isFetchingMore = false;
        emit(SavedArticlesError(message: failure.toString()));
      },
      (articles) {
        savedArticles.addAll(articles);
        isFetchingMore = false;
        hasMore = articles.length == limit;
        page++;
        emit(
          SavedArticlesLoaded(
            articles: savedArticles,
            hasMore: hasMore,
            isFetchingMore: isFetchingMore,
          ),
        );
      },
    );
  }
}
