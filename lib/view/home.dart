import 'dart:developer';

import 'package:app_sadean_helm/components/chip/chip-category.dart';
import 'package:app_sadean_helm/components/dialog/confirmation.dart';
import 'package:app_sadean_helm/components/modal/product.dart';
import 'package:app_sadean_helm/components/navbar/top-navbar.dart';
import 'package:app_sadean_helm/components/wrapper/product.dart';
import 'package:app_sadean_helm/controller/cart.dart';
import 'package:app_sadean_helm/controller/category.dart';
import 'package:app_sadean_helm/controller/product.dart';
import 'package:app_sadean_helm/model/category.dart';
import 'package:app_sadean_helm/model/product.dart';
import 'package:app_sadean_helm/sample/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> categories = [];
  List<Product> products = [];
  int selectedChipCategories = 0;
  bool isCategoriesLoading = true;
  bool isProductsLoading = true;
  bool isLoadingCart = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPage();
  }

  void _initPage() async {
    setState(() {
      isCategoriesLoading = true;
      isProductsLoading = true;
    });
    CategoryResponse categoryResponse = await fetchCategoryList();
    if (!categoryResponse.error) {
      Category selectedCategory = categoryResponse.data.first;
      setState(() {
        categories = categoryResponse.data;
        isCategoriesLoading = false;
      });

      ProductResponse productResponse =
          await fetchProductList(selectedCategory.id);
      if (!productResponse.error) {
        setState(() {
          products = productResponse.data;
          isProductsLoading = false;
        });
      }
    }
  }

  void _eventGetProductsByCategoryID(int key, int categoryID) async {
    setState(() {
      selectedChipCategories = key;
      isProductsLoading = true;
    });
    ProductResponse productResponse = await fetchProductList(categoryID);
    if (!productResponse.error) {
      setState(() {
        products = productResponse.data;
        isProductsLoading = false;
      });
    }
  }

  void _eventAddToCart(
      Product product, int qty, BuildContext modalContext) async {
    Map<String, dynamic> data = {
      "product_id": product.id,
      "qty": qty,
    };
    CartResponse cartResponse = await addToCartHandler(data);
    if (!cartResponse.error) {
      log(cartResponse.message);
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(modalContext);
    log(data.toString());
    // CartResponse cartResponse = await addToCartHandler(data);
  }

  void _showModalProduct(BuildContext rootContext, int id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      builder: (builder) {
        return ModalProduct(
          id: id,
          onCartChanged: (count) {},
          onLoadingCart: isLoadingCart,
          onAddToCart: (product, qty) {
            _eventConfirmAddToCart(context, context, product, qty);
          },
        );
      },
    );
  }

  void _eventConfirmAddToCart(BuildContext rootContext,
      BuildContext modalContext, Product product, int qty) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogConfirmation(
          title: 'Confirmation',
          content: 'Apakah Anda Yakin Ingin Menambah Keranjang?',
          onYesTap: () {
            Navigator.pop(context);
            _eventAddToCart(product, qty, modalContext);
          },
          onNoTap: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const TopNavbar(
                height: 70,
                backgroundColor: Colors.white,
                color: Colors.black,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ChipCategory(
                        data: categories,
                        selectedChip: selectedChipCategories,
                        onLoading: isCategoriesLoading,
                        onChipChange: (key, id) {
                          _eventGetProductsByCategoryID(key, id);
                        },
                      ),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double height = constraints.maxHeight;
                            return ProductWrapper(
                              data: products,
                              onLoading: isProductsLoading,
                              onRefresh: () async {
                                _initPage();
                              },
                              onCardTap: (product) {
                                _showModalProduct(context, product.id);
                              },
                              height: height,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
