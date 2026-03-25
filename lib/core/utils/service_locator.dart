import 'package:dio/dio.dart';
import 'package:eyego_task/core/utils/api_service.dart';
import 'package:eyego_task/core/utils/image_helper.dart';
import 'package:eyego_task/features/auth/data/repo/auth_repo_impl.dart';
import 'package:eyego_task/features/home/data/repo/news_repo_impl.dart';
import 'package:eyego_task/features/home/data/repo/supabase_repo.dart';
import 'package:eyego_task/features/home/data/repo/supabase_repo_impl.dart';
import 'package:eyego_task/features/profile/data/repo/images_repo_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

void setup() {
  //getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);
  getIt.registerSingleton<SupabaseRepo>(SupabaseRepoImpl());

  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl());
  getIt.registerSingleton<ImagesRepoImpl>(ImagesRepoImpl());
  getIt.registerSingleton<ImageHelper>(ImageHelper());
  getIt.registerSingleton<ImageCropper>(ImageCropper());

  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<ApiService>(ApiService(getIt.get<Dio>()));
  getIt.registerSingleton<NewsRepoImpl>(NewsRepoImpl());
}
