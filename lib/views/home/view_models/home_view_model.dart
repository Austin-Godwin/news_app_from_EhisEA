import 'package:flutter/material.dart';
import 'package:general_app/models/articles.dart';
import 'package:general_app/services/article_services.dart';

class HomeViewModel extends ChangeNotifier {
  final ArticleServices _articleServices = ArticleServices();
  List<Article> topHeadlines = [];
  int page = 1;
  static const int pageLimit = 20;

  // The List bookmark variable has been moved out of this file and moved
  // to its own file called bookmark_view_model.dart, because the bookmark
  // features only works for All news, what if we are to bookmark for other
  // categories, there's no way for the List bookmark variable to communicate with
  // the other if it is placed here, so we have to lift the state and to do so,
  // the bookmark related function would have their view models.
  // // List<Article> bookmark = [];

  //Please note, the reason for isLoading is so that when scrolling,
  //We don't want the api to be called severally as it makes it too expensive
  //and exhaust the api faster
  bool isLoading = false;

  //This is one way to call a method in a class that the app need at the
  //beginning of it's life, once the class has been instantiated whereever
  //it is been used, the method is automatically called.
  //It's just like calling methods in an initState of a stateFul Widget.
  HomeViewModel() {
    getTopHeadlines();
  }

//This is the first call of the api, we don't need to check if it is loading
//because at first, it loads the data generally.
  Future<void> getTopHeadlines() async {
    isLoading = true;
    notifyListeners();
    page = 1;
    topHeadlines =
        await _articleServices.getTopArticles(pageSize: pageLimit, page: page);
    ++page;
    print(page);
    isLoading = false;
    notifyListeners();
  }

  // The addToBookmark method has been moved out of this file and moved
  // to its own file called bookmark_view_model.dart, because the bookmark
  // features only works for All news, what if we are to bookmark for other
  // categories, there's no way for the addTobookmark to communicate with
  // the other if it is placed here, so we have to lift the state and to do so,
  // the bookmark related function would have their view models. 
  // // addToBookmark(Article article) async {
  // //   bookmark.add(article);
  // //   notifyListeners();
  // // }

//At this stage we want to check if it is loading,
//that is if the user is needs more data and scrolling is
//taking place already.
  Future<void>getMore() async {
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
      topHeadlines.addAll(await _articleServices.getTopArticles(
          pageSize: pageLimit, page: page));
      //increase page to set current page
      ++page;
      print(page);
      //After all the execution has been carried, set isLoading to false
      isLoading = false;
      //notify state
      notifyListeners();
    }
  }

  // The removeFromBookmark method has been moved out of this file and moved
  // to its own file called bookmark_view_model.dart, because the bookmark
  // features only works for All news, what if we are to bookmark for other
  // categories, there's no way for the removeFromBookmark to communicate with
  // the other if it is placed here, so we have to lift the state and to do so,
  // the bookmark related function would have their view models.
  // // removeFromBookmark(Article article) {
  // //   bookmark.remove(article);
  // //   notifyListeners();
  // // }
}
