
import 'package:airbnb/common/cached_image.dart';
import 'package:airbnb/models/property_model/model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class HouseCard extends StatelessWidget {
  const HouseCard({super.key, required this.prop});
  final PropertyModel prop;
  void viewDetailsPress(BuildContext context, String id) {
    context.go('/home/details/$id');
  }
  double _calculateFontSize(
      double screenWidth) {
    return screenWidth > 400 ? 30 : 20;
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final contentPadding = EdgeInsets.symmetric(horizontal: screenWidth * 0.05);
    final contentWidth = screenWidth - contentPadding.horizontal;

    return Padding(
      padding: contentPadding,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(20, 20),
                ),
              ],
            ),
            child: AppImage(screenWidth: screenWidth,imageUrl: prop.thumbImage,),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: contentWidth,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        prop.address.toString(),
                        maxLines: 1,
                        style:  TextStyle(
                          fontSize: _calculateFontSize(screenWidth),
                          shadows:const [
                             Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "\$${prop.priceDaily}",
                          style:  TextStyle(
                            fontSize:_calculateFontSize(screenWidth),
                            shadows:const [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () => viewDetailsPress(context, prop.id),
                          child: const Text(
                            "Show Details",
                            softWrap: true,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}


