import 'package:flutter/material.dart';
import 'package:general_app/models/articles.dart';

class BookmarkViewModel extends ChangeNotifier {
  final List<Article> bookmark = [];

  addToBookmark(Article article) {
    bookmark.add(article);
  }

  removeFromBookmark(Article article) {
    bookmark.remove(article);

    // bookmark.removeWhere((other) => article == other
    //     // other.image == article.image &&
    //     // other.content == article.content &&
    //     // other.publishedAt == article.publishedAt &&
    //     // other.title == article.title &&
    //     // other.source == article.source
    //     );
    notifyListeners();
  }
}
