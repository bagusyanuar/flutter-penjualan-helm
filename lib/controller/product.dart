import 'dart:developer';

import 'package:app_sadean_helm/controller/util.dart';
import 'package:app_sadean_helm/model/product.dart';
import 'package:app_sadean_helm/sample/data.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductResponse {
  bool error;
  String message;
  List<Product> data;

  ProductResponse({
    required this.error,
    required this.message,
    required this.data,
  });
}

class ProductByIDResponse {
  bool error;
  String message;
  Product? data;

  ProductByIDResponse({
    required this.error,
    required this.message,
    this.data,
  });
}

Future<ProductResponse> fetchProductList(int categoryID, String name) async {
  ProductResponse productResponse = ProductResponse(
    error: true,
    message: "internal server error",
    data: [],
  );
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("token");
    final response = await Dio()
        .get("$hostApiAddress/category/$categoryID/product?param=$name",
            options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer $token"
              },
            ));
    log(response.data.toString());
    List<dynamic> productsData = response.data['data'];
    List<Product> data = productsData.map((e) => Product.fromJson(e)).toList();
    productResponse = ProductResponse(
      error: false,
      message: "success",
      data: data,
    );
  } on DioException catch (e) {
    productResponse = ProductResponse(
      error: true,
      message: "internal server error",
      data: [],
    );
  }
  return productResponse;
}

Future<ProductByIDResponse> fetchProductByID(int id) async {
  ProductByIDResponse responseProductByID = ProductByIDResponse(
    error: true,
    message: "internal server error",
  );
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("token");
    final response = await Dio().get("$hostApiAddress/product/$id",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ));
    log(response.data.toString());
    dynamic productData = response.data['data'] as dynamic;
    log(productData.toString());
    Product? resultProduct;
    if (productData != null) {
      resultProduct = Product.fromJson(productData);
    }
    responseProductByID = ProductByIDResponse(
      error: false,
      message: "success",
      data: resultProduct,
    );
  } on DioException catch (e) {
    responseProductByID = ProductByIDResponse(
      error: true,
      message: "internal server error",
    );
  }
  return responseProductByID;
}
