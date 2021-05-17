import 'package:berita/components/shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        children: [
          Expanded(flex: 5, child: ShimmerBox()),
          Expanded(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: ShimmerBox(
                            height: 20,
                            width: 150,
                          ))),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: ShimmerBox(height: 20)),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: ShimmerBox(height: 20)),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: ShimmerBox(
                            height: 20,
                            width: 100,
                          ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     SizedBox(child: ShimmerBox(height: 20)),
    //     SizedBox(height: 5), // Padding
    //     SizedBox(child: ShimmerBox(height: 20, width: 250)),
    //     SizedBox(height: 5), // Padding
    //     SizedBox(child: ShimmerBox(height: 200)),
    //     SizedBox(height: 5), // Padding
    //     SizedBox(child: ShimmerBox(height: 20, width: 250)),
    //   ],
    // ),
    // );
  }
}
