import 'package:flutter/material.dart';
import 'package:general_app/views/home/view_models/bookmark_view_model.dart';
import 'package:general_app/widgets/article_widget.dart';
import 'package:general_app/extensions/string_extensions.dart';
import 'view_models/category_view_model.dart';

class CategoryView extends StatelessWidget {
  final String category;
  final CategoryViewModel categoryViewModel;
  final BookmarkViewModel bookmarkViewModel;
  const CategoryView({
    Key? key,
    required this.category,
    required this.categoryViewModel,
    required this.bookmarkViewModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: categoryViewModel,
      builder: ((context, _) {
        return NotificationListener(
          onNotification: (Notification notification) {
            switch (notification.runtimeType) {
              case ScrollUpdateNotification:
              case ScrollEndNotification:
              case UserScrollNotification:
                final notificationListerner =
                    notification as ScrollNotification;
                if (notificationListerner.metrics.pixels >
                    notificationListerner.metrics.maxScrollExtent - 300) {
                  categoryViewModel.getMore;
                }
                break;
              default:
                break;
            }
            //Return false to
            // allow the notification to continue
            //to be dispatched to further ancestors.
            return false;
          },
          child: RefreshIndicator(
            onRefresh: categoryViewModel.getArticles,
            child: CustomScrollView(
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
            ),
          ),
        );
      }),
    );
  }
}
