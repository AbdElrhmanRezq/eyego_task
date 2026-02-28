import 'package:bloc/bloc.dart';
import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/profile/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  final SupabaseClient supabase = getIt.get<SupabaseClient>();
  UserDataCubit() : super(UserDataInitial());

  Future<void> fetchUserData() async {
    emit(UserDataLoading());
    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        final response = await supabase
            .from('users')
            .select()
            .eq('u_id', user.id)
            .single();

        final userModel = UserModel.fromJson(response);
        emit(UserDataLoaded(userModel));
      } else {
        emit( UserDataError('No user is currently logged in.'));
      }
    } catch (e) {
      emit(UserDataError(e.toString()));
    }
  }
}
