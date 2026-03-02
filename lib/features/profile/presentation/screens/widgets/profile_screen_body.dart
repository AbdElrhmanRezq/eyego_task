import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/app_router.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/core/widgets/app_button.dart';
import 'package:eyego_task/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/article.dart';
import 'package:eyego_task/features/profile/presentation/cubit/saved_articles_cubit/saved_articles_cubit.dart';
import 'package:eyego_task/features/profile/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:eyego_task/features/profile/presentation/screens/widgets/profile_image.dart';
import 'package:eyego_task/features/profile/presentation/screens/widgets/saved_articles_list.dart';
import 'package:eyego_task/features/profile/presentation/screens/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<SavedArticlesCubit>().getSavedArticles();

    controller.addListener(() {
      final cubit = context.read<SavedArticlesCubit>();
      if (controller.position.maxScrollExtent == controller.offset) {
        setState(() {
          cubit.getSavedArticles();
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (state is UserDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserDataError) {
          return Center(child: Text(state.message));
        } else if (state is UserDataLoaded) {
          return CustomScrollView(
            controller: controller,

            slivers: [
              SliverToBoxAdapter(
                child: ProfileImage(height: height, state: state),
              ),
              UserInfo(state: state),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Saved Articles",
                          style: Styles.textStyle30.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 4,
                        color: kMainColor,
                        endIndent: width - 140,
                      ),
                    ],
                  ),
                ),
              ),
              SavedArticlesList(width: width, height: height),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
