import 'package:app_sadean_helm/components/order/order.card.shimmer.dart';
import 'package:app_sadean_helm/components/order/order.dart';
import 'package:app_sadean_helm/model/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrderListWrapper extends StatelessWidget {
  final bool onLoading;
  final List<Order> orders;
  final Function(int id) onOrderTap;

  const OrderListWrapper({
    Key? key,
    required this.onLoading,
    required this.orders,
    required this.onOrderTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: onLoading
          ? const [
              OrderCardShimmer(),
              OrderCardShimmer(),
              OrderCardShimmer(),
              OrderCardShimmer(),
              OrderCardShimmer(),
            ]
          : orders.map((e) {
              return CardOrder(
                item: e,
                onOrderTap: onOrderTap,
              );
            }).toList(),
    );
  }
}
