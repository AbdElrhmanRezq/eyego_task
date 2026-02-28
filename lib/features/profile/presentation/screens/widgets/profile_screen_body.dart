import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/app_router.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/core/widgets/app_button.dart';
import 'package:eyego_task/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:eyego_task/features/profile/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
     double height = MediaQuery.of(context).size.height;
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if(state is UserDataLoading){
          return const Center(child: CircularProgressIndicator());
        }
        else if(state is UserDataError){
          return Center(child: Text(state.message));
        }
        else if (state is UserDataLoaded){
          return Column(
            children: [
              Container(
                height: height * 0.45,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      state.user.profileImage,
                      fit: BoxFit.cover,
                    ),

                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, kBackground],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 10,
                      child: Stack(
                        children: [
                          Opacity(opacity: 0.1,child: Container(height: 48,width:48,decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(50)))),
                          IconButton(
                            onPressed: () {
                              GoRouter.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_back_ios_new, color: kMainColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),                
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.user.username,
                    style: Styles.textStyle30.copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 10),
                
                  Text(
                    (context)
                            .read<AuthCubit>()
                            .auth
                            .supabase
                            .auth
                            .currentUser
                            ?.email ??
                        ' ',
                    style: Styles.textStyle16,
                  ),
                  SizedBox(height: 20),
                
                  AppButton(
                    text: "Logout",
                    onPressed: () {
                      (context).read<AuthCubit>().auth.logout();
                      GoRouter.of(context).pop();
                      GoRouter.of(context).push(AppRouter.kInitialRoute);
                    },
                  ),
                ],
                          ),
              ),
            ],
          );
        }
        else{
          return const SizedBox();
        }
      },
    );
  }
}
