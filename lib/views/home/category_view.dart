import 'package:flutter/material.dart';
import 'package:general_app/widgets/article_widget.dart';
import 'package:general_app/extensions/string_extensions.dart';

import 'view_models/category_view_model.dart';

class CategoryView extends StatelessWidget {
  final String category;
  final CategoryViewModel categoryViewModel;
  const CategoryView({
    Key? key,
    required this.category,
    required this.categoryViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: categoryViewModel,
      builder: ((context, _) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                category.capitaliseFirstLetter(),
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final article = categoryViewModel.articles[index];
                  return ArticleWidget(article: article);
                },
                childCount: categoryViewModel.articles.length,
              ),
            ),
          ],
        );
      }),
    );
  }
}
