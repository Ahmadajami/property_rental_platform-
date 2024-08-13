import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'Loading.dart';

class AppImage extends StatelessWidget {
  const AppImage({super.key, required this.screenWidth, required this.imageUrl});
  final double screenWidth;
  final String? imageUrl;


  @override
  Widget build(BuildContext context) {
    if( imageUrl == null)
      {
        return Icon(Icons.home);
      }
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageProvider,
            )),
        width: screenWidth,
      ),
      placeholder: (context, url) =>
      const Center(child:Loading()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
