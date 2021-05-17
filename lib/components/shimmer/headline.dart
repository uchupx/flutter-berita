import 'package:berita/components/shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHeadline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(child: ShimmerBox(height: 20)),
          SizedBox(height: 5), // Padding
          SizedBox(child: ShimmerBox(height: 20, width: 250)),
          SizedBox(height: 5), // Padding
          SizedBox(child: ShimmerBox(height: 200)),
          SizedBox(height: 5), // Padding
          SizedBox(child: ShimmerBox(height: 20, width: 250)),
        ],
      ),
    );
  }
}
