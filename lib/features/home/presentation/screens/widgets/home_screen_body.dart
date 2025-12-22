import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/presentation/cubit/news_cubit/news_cubit.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/article_image.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/explore_bar.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/filter_row.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/news_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final ScrollController controller = ScrollController();
  String selectedCategory = 'general';
  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().fetchHeadlines();

    controller.addListener(() {
      final cubit = context.read<NewsCubit>();
      if (controller.position.maxScrollExtent == controller.offset) {
        setState(() {
          cubit.fetchHeadlines(loadMore: true);
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final List<String> categories = [
      "business",
      "entertainment",
      "general",
      "health",
      "science",
      "sports",
      "technology",
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        controller: controller,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExploreBar(),
                Divider(thickness: 2, color: kMainColor),
                SizedBox(height: 10),
                FilterRow(
                  items: categories,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                      (context).read<NewsCubit>().fetchHeadlines(
                        category: selectedCategory,
                      );
                    });
                  },
                  selectedCategory: selectedCategory,
                ),
              ],
            ),
          ),
          NewsList(width: width, height: height),
        ],
      ),
    );
  }
}
