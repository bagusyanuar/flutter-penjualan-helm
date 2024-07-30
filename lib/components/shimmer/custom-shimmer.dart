import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final EdgeInsets margin;

  const CustomShimmer({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
    this.margin = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
