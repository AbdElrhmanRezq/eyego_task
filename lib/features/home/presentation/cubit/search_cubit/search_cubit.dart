import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/data/repo/news_repo.dart';
import 'package:eyego_task/features/home/data/repo/news_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  final NewsRepo newsRepo = getIt.get<NewsRepoImpl>();
  Future<void> fetchSearchedNews({required String text}) async {
    final result = await newsRepo.getEverything(q: text);
    print("===========================================");

    print(text);
    result.fold(
      (failure) {
        emit(SearchError(failure.message));
      },
      (newArticles) {
        emit(SearchLoaded(articles: newArticles));
      },
    );
  }
}
