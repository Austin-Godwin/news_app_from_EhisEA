import 'package:flutter/material.dart';
import 'package:general_app/services/article_services.dart';
import '../../../models/articles.dart';

class CategoryViewModel extends ChangeNotifier {
  ArticleServices articleServices = ArticleServices();
  List<Article> articles = [];
  final String category;
  int page = 1;
  int pageLimit = 20;
  bool isLoading = false;

  CategoryViewModel(this.category) {
    getArticles();
  }

  Future<void> getArticles() async {
    isLoading = true;
    notifyListeners();
    page = 1;
    articles = await articleServices.getArticlesByCategory(category,
        pageSize: pageLimit, page: page);
    ++page;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getMore() async {
    //Check if isLoading if false
    //Note that the ! in the isLoading means that isLoading is false
    //Because since it is boolean, the ! means not which stands for false
    //Also note, forget the initial value of isLoading at its first declaration
    if (!isLoading) {
      //once isLoading is false, and the function has been
      //triggered, make isLoading true
      isLoading = true;
      //notify state
      notifyListeners();
      //get more article and add it to the current list
      articles.addAll(
        await articleServices.getArticlesByCategory(
          category,
          pageSize: pageLimit,
          page: page,
        ),
      );
      //increase page to set current page
      ++page;
      //After all the execution has been carried, set isLoading to false
      isLoading = false;
      //notify state
      notifyListeners();
    }
  }
}
