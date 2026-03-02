import 'package:bloc/bloc.dart';
import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/data/repo/supabase_repo.dart';
import 'package:eyego_task/features/home/data/repo/supabase_repo_impl.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit() : super(ArticleInitial());
  final SupabaseRepo repo = getIt.get<SupabaseRepo>();
  bool isSaved = false;

  Future<void> toggleSave(ArticleModel article) async {
    emit(Articletoggling());
    try {
      await repo.toggleSave(article);
      isSaved = !isSaved;
      emit(ArticleToggled(isSaved: isSaved));
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }

  Future<void> isArticleSaved(ArticleModel article) async {
    final response = await repo.checkSaveStatus(article);
    print(response);
    response.fold(
      (faliure) {
        isSaved = false;
      },
      (check) {
        isSaved = check;
        emit(ArticleToggled(isSaved: isSaved));
      },
    );
  }
}
