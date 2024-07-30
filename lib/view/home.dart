import 'dart:developer';

import 'package:app_sadean_helm/components/chip/chip-category.dart';
import 'package:app_sadean_helm/components/navbar/top-navbar.dart';
import 'package:app_sadean_helm/components/wrapper/product.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPage();
  }

  void _initPage() async {
    setState(() {
      isCategoriesLoading = true;
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

  void _showModalProduct(BuildContext rootContext, int id) {}

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
                          setState(() {
                            selectedChipCategories = key;
                          });
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
                              onCardTap: (product) {},
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
