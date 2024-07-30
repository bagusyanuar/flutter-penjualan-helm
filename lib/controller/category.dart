import 'dart:developer';

import 'package:app_sadean_helm/controller/util.dart';
import 'package:app_sadean_helm/model/category.dart';
import 'package:app_sadean_helm/sample/data.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryResponse {
  bool error;
  String message;
  List<Category> data;

  CategoryResponse({
    required this.error,
    required this.message,
    required this.data,
  });
}

Future<CategoryResponse> fetchCategoryList() async {
  CategoryResponse categoryResponse = CategoryResponse(
    error: true,
    message: "internal server error",
    data: [],
  );
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("token");
    final response = await Dio().get("$hostApiAddress/category",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ));
    log(response.data.toString());
    List<dynamic> categoriesData = response.data['data'];
    List<Category> data =
        categoriesData.map((e) => Category.fromJson(e)).toList();
    categoryResponse = CategoryResponse(
      error: false,
      message: "success",
      data: data,
    );
  } on DioException catch (e) {
    log("Error ${e.response}");
    categoryResponse = CategoryResponse(
      error: true,
      message: "internal server error",
      data: [],
    );
  }
  return categoryResponse;
}
