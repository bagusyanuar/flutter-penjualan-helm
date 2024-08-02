import 'package:app_sadean_helm/components/shimmer/custom-shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartCardShimmer extends StatelessWidget {
  const CartCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(4, 4), // changes position of shadow
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomShimmer(
            height: 80,
            width: 80,
            radius: 10,
            margin: EdgeInsets.only(right: 10),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShimmer(
                  height: 16,
                  width: 120,
                  radius: 5,
                  margin: EdgeInsets.only(bottom: 5),
                ),
                CustomShimmer(height: 20, width: 80, radius: 5),
              ],
            ),
          ),
          // SizedBox(
          //   height: 80,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       CustomShimmer(height: 25, width: 25, radius: 5),
          //       CustomShimmer(
          //         height: 30,
          //         width: 40,
          //         radius: 5,
          //         margin: EdgeInsets.symmetric(horizontal: 5),
          //       ),
          //       CustomShimmer(height: 25, width: 25, radius: 5),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
