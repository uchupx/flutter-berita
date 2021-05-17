import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  ShimmerBox({Key key, this.height, this.width}) : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shimmer.fromColors(
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          baseColor: Colors.black38,
          highlightColor: Colors.black12),
    );
  }
}
