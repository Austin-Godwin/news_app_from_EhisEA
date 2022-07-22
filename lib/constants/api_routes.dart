import 'keys.dart';

class ApiRoutes {
  static String baseUrl = "https://newsapi.org";

  static String topHeadlines(int pageSize, int page) =>
      "$baseUrl/v2/top-headlines?country=ng&apiKey=${ApiKeys.apiKey}&pageSize=$pageSize&page$page";

  static String getArticleByCatigoty(String category, int pageSize, int page) =>
      "$baseUrl/v2/top-headlines?country=ng&category=$category&apiKey=${ApiKeys.apiKey}&pageSize=$pageSize&page=$page";
}
