import 'package:flutter/material.dart';
import 'package:general_app/models/articles.dart';
import 'package:general_app/widgets/cached_image.dart';

class ArticleDisplay extends StatelessWidget {
  final Article article;
  const ArticleDisplay({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: OrientationBuilder(
              builder: (context, orientation) {
                final Widget image = Hero(
                  tag: article.title,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    width: 100,
                    height: 110,
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
                        : CachedImage(imageUrl: article.image!),
                  ),
                );
                if (Orientation.landscape != orientation) {
                  return AspectRatio(
                    aspectRatio: 3 / 2,
                    child: image,
                  );
                }
                return image;
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 5,
                    ),
                  ),
                ),
                child: Text(
                  article.title,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                      ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                article.content * 5,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      height: 1.5,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
