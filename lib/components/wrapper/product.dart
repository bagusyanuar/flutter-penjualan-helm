import 'package:app_sadean_helm/components/content/product.dart';
import 'package:app_sadean_helm/components/shimmer/custom-shimmer.dart';
import 'package:app_sadean_helm/model/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductWrapper extends StatelessWidget {
  final List<Product> data;
  final bool onLoading;
  final Function(Product product) onCardTap;
  final AsyncCallback onRefresh;
  final double height;

  const ProductWrapper(
      {Key? key,
      required this.data,
      required this.onLoading,
      required this.onRefresh,
      required this.onCardTap,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onLoading
        ? GridView.count(
            padding: const EdgeInsets.only(bottom: 60),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 4,
            children: [1, 2, 3, 4, 5, 6].map((e) {
              return const CustomShimmer(height: 0, width: 0, radius: 10);
            }).toList(),
          )
        : ContentProduct(
            data: data,
            onRefresh: onRefresh,
            onCardTap: onCardTap,
            height: height,
          );
  }
}
