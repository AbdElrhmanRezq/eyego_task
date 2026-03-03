import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/functions/url_launcher.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/core/widgets/app_button.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/presentation/cubit/article_cubit/article_cubit.dart';
import 'package:eyego_task/features/home/presentation/cubit/comments_cubit/comments_cubit.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/article_image.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/comment_text_field.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/comments.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleScreenBody extends StatefulWidget {
  final ArticleModel article;

  const ArticleScreenBody({super.key, required this.article});

  @override
  State<ArticleScreenBody> createState() => _ArticleScreenBodyState();
}

class _ArticleScreenBodyState extends State<ArticleScreenBody> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CommentsCubit>().fetchComments(article: widget.article);

    controller.addListener(() {
      final cubit = context.read<CommentsCubit>();
      if (controller.position.maxScrollExtent == controller.offset) {
        setState(() {
          cubit.fetchComments(article: widget.article);
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomScrollView(
        controller: controller,
        slivers: [
          SliverToBoxAdapter(
            child: Text(widget.article.name ?? ' ', style: Styles.textStyle20),
          ),
          SliverToBoxAdapter(
            child: Text(widget.article.title ?? ' ', style: Styles.textStyle16),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverToBoxAdapter(
            child: ArticleImage(
              width: width,
              height: height,
              article: widget.article,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          widget.article.author != null
              ? SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Author: ${widget.article.author}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              : SliverToBoxAdapter(child: SizedBox()),
          widget.article.author != null
              ? SliverToBoxAdapter(child: SizedBox(height: 10))
              : SliverToBoxAdapter(child: SizedBox()),

          SliverToBoxAdapter(
            child: Text(
              widget.article.description ?? ' ',
              style: Styles.textStyle14,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10)),

          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocConsumer<ArticleCubit, ArticleState>(
                  builder: (context, state) {
                    if (state is Articletoggling) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ArticleToggled) {
                      return Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<ArticleCubit>().toggleSave(
                                widget.article,
                              );
                            },
                            icon: state.isSaved
                                ? Icon(
                                    Icons.bookmark,
                                    color: kMainColor,
                                    size: 36,
                                  )
                                : Icon(
                                    Icons.bookmark_border,
                                    color: kMainColor,
                                    size: 36,
                                  ),
                          ),
                          Text(
                            "${state.saveCount}",
                            style: Styles.textStyle18.copyWith(
                              color: kMainColor,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                  listener: (context, state) {
                    if (state is ArticleError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: CommentTextField(article: widget.article)),
          Comments(),
        ],
      ),
    );
  }
}
