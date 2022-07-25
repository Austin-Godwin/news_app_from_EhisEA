import 'package:flutter/material.dart';
import 'package:general_app/main.dart';
import 'package:general_app/models/articles.dart';
import 'package:general_app/views/home/article_display.dart';
import 'cached_image.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleWidget extends StatelessWidget {
  final Article article;
  // final bool isBookmarked;
  // final Function(Article)? onBookmark;
  const ArticleWidget({
    Key? key,
    required this.article,
    // this.isBookmarked = false,
    // this.onBookmark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookmarkViewModel = Home.of(context).bookmarkViewModel;
    final isBooked =
        Home.of(context).bookmarkViewModel.bookmark.contains(article);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ArticleDisplay(article: article),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 110,
          child: Row(
            children: [
              Hero(
                tag: article.title,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 110,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.grey.shade300,
                  ),
                  child: article.image == null
                      ? const Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 50.0,
                        )
                      : CachedImage(
                          imageUrl: article.image!,
                        ),
                ),
              ),
              const SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          article.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          timeago.format(article.publishedAt),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => isBooked
                              ? bookmarkViewModel.removeFromBookmark(article)
                              : bookmarkViewModel.addToBookmark(article),
                          // onBookmark?.call(article),
                          child: Icon(
                            isBooked
                                // isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border_rounded,
                            color: isBooked
                                // isBookmarked
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                        ),
                      ],
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
