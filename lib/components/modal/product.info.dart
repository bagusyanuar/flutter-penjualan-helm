import 'package:app_sadean_helm/components/shimmer/custom-shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ModalProductInfo extends StatelessWidget {
  final String name;
  final int price;
  final bool onLoading;

  const ModalProductInfo({
    super.key,
    required this.name,
    required this.price,
    required this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('id');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        onLoading
            ? const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: CustomShimmer(
                  height: 18,
                  width: 150,
                  radius: 5,
                ),
              )
            : Text(
                name,
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 18,
                ),
              ),
        onLoading
            ? const CustomShimmer(
                height: 24,
                width: 100,
                radius: 5,
              )
            : Text(
                'Rp${numberFormat.format(price)}',
                style: const TextStyle(
                    color: Colors.brown,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
      ],
    );
  }
}
