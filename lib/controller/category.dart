import 'package:app_sadean_helm/model/category.dart';
import 'package:app_sadean_helm/sample/data.dart';

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
  CategoryResponse response = CategoryResponse(
    error: true,
    message: "internal server error",
    data: [],
  );
  try {
    await Future.delayed(const Duration(seconds: 1));
    List<Category> data =
        sampleCategories.map((e) => Category.fromJson(e)).toList();
    response = CategoryResponse(
      error: false,
      message: "success",
      data: data,
    );
  } catch (e) {
    response = CategoryResponse(
      error: true,
      message: "internal server error",
      data: [],
    );
  }
  return response;
}
