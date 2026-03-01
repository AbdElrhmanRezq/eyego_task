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

  Future<void> saveArticle(ArticleModel article) async {
    emit(ArticleSaving());
    try {
      await repo.saveArticle(article);
      emit(ArticleSaved());
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }
}
