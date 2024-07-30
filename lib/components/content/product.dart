import 'package:app_sadean_helm/components/card/card-product.dart';
import 'package:app_sadean_helm/model/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ContentProduct extends StatelessWidget {
  final List<Product> data;
  final AsyncCallback onRefresh;
  final Function(Product product) onCardTap;
  final double height;

  const ContentProduct(
      {Key? key,
      required this.data,
      required this.onRefresh,
      required this.onCardTap,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: data.isEmpty
            ? SizedBox(
                height: double.infinity,
                width: double.infinity,
                // color: Colors.blue,
                child: Center(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      // color: Colors.amber,
                      height: height,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/no-data.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const Text(
                            'no data available',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : GridView.count(
                padding: const EdgeInsets.only(bottom: 60),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4,
                children: data.map((e) {
                  return CardProduct(
                    product: e,
                    onTap: onCardTap,
                  );
                }).toList(),
              ),
      ),
    );
  }
}
