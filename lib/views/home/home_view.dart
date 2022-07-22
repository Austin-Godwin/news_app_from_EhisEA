import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:general_app/enum/news_category.dart';
import 'package:general_app/extensions/string_extensions.dart';
import 'package:general_app/views/home/category_view.dart';
import 'package:general_app/views/home/view_models/home_view_model.dart';
import 'package:general_app/widgets/article_widget.dart';
import 'view_models/category_view_model.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel homeViewModel;
  const HomeView({Key? key, required this.homeViewModel}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  @override
  void initState() {
    widget.homeViewModel.getTopHeadlines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (tappedIndex) {
          setState(() {
            selectedIndex = tappedIndex;
          });
        },
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: "Bookmark",
          ),
        ],
      ),
      body: SafeArea(
        child: selectedIndex == 1
            ? ListView.builder(
                itemCount: widget.homeViewModel.bookmark.length,
                itemBuilder: (context, index) {
                  final article = widget.homeViewModel.bookmark[index];
                  return ArticleWidget(article: article);
                },
              )
            : DefaultTabController(
                length: ArticleCategory.values.length + 1,
                child: Column(
                  children: [
                    const SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Ink.image(
                        image: const AssetImage(
                          "assets/images/logo.png",
                        ),
                        height: 40.0,
                        width: 100.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TabBar(
                      labelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: true,
                      tabs: [
                        const Text(
                          "All news",
                          // style: Theme.of(context).textTheme.bodyText1
                        ),
                        for (ArticleCategory item in ArticleCategory.values)
                          Tab(
                            height: 20,
                            text: item.name.capitaliseFirstLetter(),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: TabBarView(
                        children: [
                          AnimatedBuilder(
                            animation: widget.homeViewModel,
                            builder: (context, _) {
                              return NotificationListener(
                                onNotification: (Notification notification) {
                                  // flutter: ScrollEndNotification(depth: 0 (local), FixedScrollMetrics(0.0..[584.0]..1))
                                  // flutter: UserScrollNotification(depth: 0 (local), FixedScrollMetrics(0.0..[584.0]), direction: ScrollDirection.idle)
                                  // flutter: ScrollMetricsNotification(depth: 0 (local), FixedScrollMetrics(0.0..[584.0]..1965.0))
                                  // ScrollMetricsNotification;
                                  // flutter: ScrollUpdateNotification;
                                  // flutter: ScrollEndNotification;
                                  // flutter: UserScrollNotification;
                                  switch (notification.runtimeType) {
                                    case ScrollUpdateNotification:
                                    case ScrollEndNotification:
                                    case UserScrollNotification:
                                      final notificationListener =
                                          notification as ScrollNotification;

                                      if (notificationListener.metrics.pixels >
                                          notificationListener
                                                  .metrics.maxScrollExtent -
                                              300) {
                                        print("Paginatable");
                                        widget.homeViewModel.getMore();
                                      }
                                      break;
                                    default:
                                      break;
                                  }
                                  return false;
                                },
                                child: RefreshIndicator(
                                  onRefresh:
                                      widget.homeViewModel.getTopHeadlines,
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverToBoxAdapter(
                                        child: Text(
                                          "Top Headlines",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                          final article = widget.homeViewModel
                                              .topHeadlines[index];
                                          final bool isBookmarked = widget
                                              .homeViewModel.bookmark
                                              .contains(article);
                                          return ArticleWidget(
                                            article: article,
                                            isBookmarked: isBookmarked,
                                            onBookmark: isBookmarked
                                                ? widget.homeViewModel
                                                    .removeFromBookmark
                                                : widget.homeViewModel
                                                    .addToBookmark,
                                          );
                                        },
                                            childCount: widget.homeViewModel
                                                .topHeadlines.length),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          for (ArticleCategory item in ArticleCategory.values)
                            CategoryView(
                              category: item.name,
                              categoryViewModel: CategoryViewModel(item.name),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
