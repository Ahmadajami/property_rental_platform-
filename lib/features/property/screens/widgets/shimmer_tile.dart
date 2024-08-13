import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTile extends StatelessWidget {
  const ShimmerTile({super.key});

  @override
  Widget build(BuildContext context) {
   return  Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // Adjust base color as needed
      highlightColor: Colors.grey[100]!, // Adjust highlight color as needed
      child: GestureDetector(
        onTap: null, // Disable tap while loading
        child: SizedBox(
          width: double.infinity,
          height: 180.0,
          child: Card(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!, // Adjust base color as needed
                    highlightColor: Colors.grey[100]!, // Adjust highlight color as needed
                    child: Container(
                      color: Colors.white, // Placeholder for image
                    ),
                  ),
                ),
                const VerticalDivider(width: 10.0),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!, // Adjust base color as needed
                        highlightColor: Colors.grey[100]!, // Adjust highlight color as needed
                        child: Container(
                          height: 20.0,
                          color: Colors.white, // Placeholder for address
                        ),
                      ),
                      const SizedBox(height: 5.0), // Spacing between address and price
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!, // Adjust base color as needed
                        highlightColor: Colors.grey[100]!, // Adjust highlight color as needed
                        child: Container(
                          height: 15.0,
                          color: Colors.white, // Placeholder for price
                        ),
                      ),
                      const SizedBox(height: 5.0), // Spacing between price and description
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!, // Adjust base color as needed
                        highlightColor: Colors.grey[100]!, // Adjust highlight color as needed
                        child: Container(
                          height: 50.0, // Adjust height based on description length
                          color: Colors.white, // Placeholder for description
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
