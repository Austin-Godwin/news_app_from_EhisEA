import 'package:flutter/material.dart';
import 'package:general_app/models/articles.dart';
import 'package:general_app/services/article_services.dart';

class HomeViewModel extends ChangeNotifier {
  final ArticleServices _articleServices = ArticleServices();
  List<Article> topHeadlines = [];
  List<Article> bookmark = [];
  int page = 1;
  static const int pageLimit = 20;

  // HomeViewModel() {
  //   getTopHeadlines();
  // }

  Future<void> getTopHeadlines() async {
    page = 1;
    topHeadlines =
        await _articleServices.getTopArticles(pageSize: pageLimit, page: page);
    ++page;
    print(page);
    notifyListeners();
  }

  addToBookmark(Article article) async {
    bookmark.add(article);
    notifyListeners();
  }

  getMore() async {
    //get more article and add it to the current list

    topHeadlines.addAll(
        await _articleServices.getTopArticles(pageSize: pageLimit, page: page));

    //increase page to the current list
    ++page;
    print(page);
    //notify state
    notifyListeners();
  }

  removeFromBookmark(Article article) {
    bookmark.remove(article);
    notifyListeners();
  }
}
