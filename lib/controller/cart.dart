import 'dart:developer';

import 'package:app_sadean_helm/controller/util.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartResponse {
  bool error;
  String message;

  CartResponse({
    required this.error,
    required this.message,
  });
}

Future<CartResponse> addToCartHandler(Map<String, dynamic> data) async {
  CartResponse cartResponse = CartResponse(
    error: true,
    message: "internal server error",
  );
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("token");
    var formData = FormData.fromMap(data);
    final response = await Dio().post(
      "$hostApiAddress/cart",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      ),
      data: formData,
    );
    log(response.data.toString());
    cartResponse = CartResponse(
      error: false,
      message: "success",
    );
  } on DioException catch (e) {
    cartResponse = CartResponse(
      error: true,
      message: "internal server error",
    );
  }
  return cartResponse;
}
