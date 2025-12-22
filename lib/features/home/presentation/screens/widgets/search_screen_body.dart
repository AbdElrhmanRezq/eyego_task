import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/text_field.dart';
import 'package:eyego_task/features/home/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({super.key});

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CustomTextFormField(
              hintText: "Search",
              icon: Icons.search,
              validator: (value) {},
              controller: searchController,
              onChanged: (value) {
                (context).read<SearchCubit>().fetchSearchedNews(text: value);
              },
            ),
          ),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchLoading) {
                return SliverToBoxAdapter(
                  child: CircularProgressIndicator(color: kMainColor),
                );
              } else if (state is SearchError) {
                return SliverToBoxAdapter(
                  child: Text(state.message, style: Styles.textStyle20),
                );
              } else if (state is SearchLoaded) {
                return SliverList.builder(
                  itemCount: state.articles.length,
                  itemBuilder: (context, index) => Article(
                    width: width,
                    height: height,
                    article: state.articles[index],
                  ),
                );
              } else {
                return SliverToBoxAdapter(child: Container());
              }
            },
          ),
        ],
      ),
    );
  }
}
