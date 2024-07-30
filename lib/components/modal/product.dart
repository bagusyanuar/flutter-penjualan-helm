import 'package:app_sadean_helm/components/modal/product.info.dart';
import 'package:app_sadean_helm/controller/product.dart';
import 'package:app_sadean_helm/model/product.dart';
import 'package:flutter/material.dart';

class ModalProduct extends StatefulWidget {
  final int id;
  final Function(int count) onCartChanged;
  final VoidCallback onGoToCart;

  const ModalProduct({
    super.key,
    required this.id,
    required this.onCartChanged,
    required this.onGoToCart,
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

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initPage();
    });
    super.initState();
  }

  void _initPage() async {
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
          ],
        );
      },
    );
  }
}
