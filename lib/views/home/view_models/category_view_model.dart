import 'package:flutter/material.dart';
import 'package:general_app/services/article_services.dart';
import '../../../models/articles.dart';

class CategoryViewModel extends ChangeNotifier {
  ArticleServices articleServices = ArticleServices();
  List<Article> articles = [];
  final String category;
  int page = 1;
  int pageLimit = 20;

  CategoryViewModel(this.category) {
    getArticle();
  }

  getArticle() async {
    articles =
        await articleServices.getArticlesByCategory(category, pageSize: pageLimit, page: page);
    notifyListeners();
  }
}
