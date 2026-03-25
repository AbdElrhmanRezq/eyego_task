import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/profile/data/repo/statistics_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StatisticsRepoImpl implements statisticsRepo {
  @override
  Future<Map<String, int>> getStatistics() async {
    final SupabaseClient supabase = getIt.get<SupabaseClient>();
    final PostgrestResponse articlesResponse = await supabase
        .from("saved_articles")
        .select("a_id")
        .eq("u_id", supabase.auth.currentUser?.id as String)
        .count(CountOption.exact);
    final PostgrestResponse usersResponse = await supabase
        .from("users")
        .select("u_id")
        .count(CountOption.exact);

    print(articlesResponse);
    print(usersResponse);
    return {
      "articles_count": articlesResponse.count,
      "users_count": usersResponse.count,
    };
  }
}
