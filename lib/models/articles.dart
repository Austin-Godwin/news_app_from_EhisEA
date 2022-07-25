class Article {
  String title;
  ArticleSource source;
  String? image;
  String content;
  DateTime publishedAt;

  Article({
    required this.title,
    required this.source,
    required this.image,
    required this.content,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json["title"],
      source: ArticleSource.fromJson(json["source"]),
      image: json["urlToImage"],
      content: json["content"] ?? "",
      publishedAt: DateTime.parse(json["publishedAt"]).toLocal(),
    );
  }

  @override
  operator ==(covariant Article other) =>
      other.image == image &&
      other.content == content &&
      other.publishedAt == publishedAt &&
      other.title == title &&
      other.source == source;

  @override
  int get hashCode =>
      image.hashCode ^
      content.hashCode ^
      publishedAt.hashCode ^
      title.hashCode ^
      source.hashCode;
}

class ArticleSource {
  // String id;
  String name;

  ArticleSource({
    // required this.id,
    required this.name,
  });

  factory ArticleSource.fromJson(Map<String, dynamic> json) {
    return ArticleSource(
      // id: json["id"],
      name: json["name"],
    );
  }

  @override
  operator ==(covariant ArticleSource other) => other.name == name;

  @override
  int get hashCode => name.hashCode;
}
