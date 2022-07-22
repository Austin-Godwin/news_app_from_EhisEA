import 'dart:convert';
import 'package:general_app/constants/api_routes.dart';
import 'package:general_app/models/articles.dart';
import 'package:http/http.dart' as http;

class ArticleServices {
  Future<List<Article>> getTopArticles({int pageSize = 20, int page = 1}) async {
    final Uri url = Uri.parse(ApiRoutes.topHeadlines(pageSize, page));
    // final http.Response response = await http.get(url);
    // final List<Map<String, dynamic>> result =
    //     jsonDecode(response.body)["article"];

    // return result.map<Articles>((item) => Articles.fromJson(item)).toList();
    return _getArticleFromServer(url);
  }

  Future<List<Article>> getArticlesByCategory(
      String category, {int pageSize = 20, int page = 1}) async {
    final Uri url = Uri.parse(
        ApiRoutes.getArticleByCatigoty(category, pageSize, page));
    // final http.Response response = await http.get(url);
    // final List<Map<String, dynamic>> result =
    //     jsonDecode(response.body)["article"];

    // return result.map<Articles>((item) => Articles.fromJson(item)).toList();
    return _getArticleFromServer(url);
  }

// creating a method to hold the service call since it the same for getArticles
// and getArticlesByCategory.
  Future<List<Article>> _getArticleFromServer(Uri url) async {
    final http.Response response = await http.get(url);
    final List result = jsonDecode(response.body)["articles"];
    return result.map<Article>((item) => Article.fromJson(item)).toList();
  }
}
