import 'package:app_sadean_helm/components/modal/product.description.dart';
import 'package:app_sadean_helm/components/modal/product.info.dart';
import 'package:app_sadean_helm/components/modal/product.quantity.dart';
import 'package:app_sadean_helm/components/shimmer/custom-shimmer.dart';
import 'package:app_sadean_helm/controller/product.dart';
import 'package:app_sadean_helm/model/product.dart';
import 'package:flutter/material.dart';

class ModalProduct extends StatefulWidget {
  final int id;
  final Function(int count) onCartChanged;
  final Function(Product product, int qty) onAddToCart;
  final bool onLoadingCart;

  const ModalProduct({
    super.key,
    required this.id,
    required this.onCartChanged,
    required this.onAddToCart,
    required this.onLoadingCart,
  });

  @override
  State<ModalProduct> createState() => _ModalProductState();
}

class _ModalProductState extends State<ModalProduct> {
  TextEditingController textEditingController = TextEditingController();
  Product product = Product(
      id: 0,
      name: '',
      image: '',
      price: 0,
      description: '',
      qty: 0,
      categoryID: 0);

  bool onLoading = true;
  int qty = 0;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initPage();
    });
    super.initState();
  }

  void _initPage() async {
    textEditingController.text = '1';
    setState(() {
      onLoading = true;
    });
    ProductByIDResponse responseProductByID = await fetchProductByID(widget.id);
    if (!responseProductByID.error) {
      Product? p = responseProductByID.data;
      if (p != null) {
        setState(() {
          onLoading = false;
          product = p;
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.2,
      maxChildSize: 0.75,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: ModalProductInfo(
                name: product.name,
                price: product.price,
                onLoading: onLoading,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Divider(),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: ModalProductDescription(
                  image: product.image,
                  description: product.description,
                  onLoading: onLoading,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ModalProductQuantity(
                onLoading: onLoading,
                textEditingController: textEditingController,
                onQtyChange: (qtyString) {
                  textEditingController.text = qtyString;
                  int value = int.parse(qtyString);
                  setState(() {
                    qty = value;
                  });
                  // _onQtyChange(product, qty);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
              child: onLoading
                  ? const CustomShimmer(
                      height: 50,
                      width: double.infinity,
                      radius: 5,
                    )
                  : GestureDetector(
                      onTap: () {
                        widget.onAddToCart(product, qty);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: widget.onLoadingCart
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.only(right: 5),
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    "loading...",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )
                            : const Center(
                                child: Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                      ),
                    ),
            )
          ],
        );
      },
    );
  }
}
