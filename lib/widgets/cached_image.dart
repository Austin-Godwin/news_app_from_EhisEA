import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends CachedNetworkImage {
  CachedImage({
    Key? key,
    required String imageUrl,
    BoxFit? fit,
  }) : super(
          key: key,
          imageUrl: imageUrl,
          fit: fit ?? BoxFit.cover,
          errorWidget: (_, __, ___) {
            return const Icon(Icons.fastfood_outlined);
          },
          placeholder: (context, _) => Container(
            color: Colors.black,
          ),
        );
}

// class Cached extends StatelessWidget {
//   final String imageUrl;
//   final BoxFit? fit;
//   const Cached({Key? key, required this.imageUrl, this.fit}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: imageUrl,
//       fit: fit ?? BoxFit.cover,
//       errorWidget: (_, __, ___) {
//         return const Icon(Icons.fastfood_outlined);
//       },
//       placeholder: (context, _) => Container(
//         color: Colors.black,
//       ),
//     );
//   }
// }
