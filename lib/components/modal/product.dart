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

  void _initPage() async {
    setState(() {
      onLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
