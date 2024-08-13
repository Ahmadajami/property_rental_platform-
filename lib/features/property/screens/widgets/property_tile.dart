import 'package:airbnb/models/property_model/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PropertyTile extends StatelessWidget {
  const PropertyTile({super.key, required this.property});
  final  PropertyModel property;

  Widget decoratedNetworkImage( PropertyModel prop ){
    return CachedNetworkImage(
      imageUrl: prop.thumbImage ?? "https://picsum.photos/200",
      imageBuilder: (context, imageProvider) {
        return   ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            height:double.infinity ,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imageProvider,
                )),

          ),
        );

      },
      placeholder: (context, url) => const Center(child:  CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        context.go('/all/details/${property.id}');
      },
      child: SizedBox(
        width: double.infinity,
        height: 180.0,
        child: Card(
          child: Row(children: [
            Expanded(flex: 1,child: decoratedNetworkImage(property)),
            const VerticalDivider(width: 10.0),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(property.address,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis),
                      softWrap: true),
                  Text(
                    "price :${property.priceDaily}",
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis),
                    softWrap: true,
                  ),
                  const Divider(),
                  Text(
                    "Description:\n ${property.description}",style: const TextStyle(overflow: TextOverflow.ellipsis),),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
