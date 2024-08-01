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

class CheckoutResponse {
  bool error;
  String message;
  String? token;

  CheckoutResponse({
    required this.error,
    required this.message,
    required this.token,
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

Future<CheckoutResponse> checkoutHandler(Map<String, dynamic> data) async {
  CheckoutResponse checkoutResponse = CheckoutResponse(
      error: true, message: "internal server error", token: null);
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("token");
    var formData = FormData.fromMap(data);
    final response = await Dio().post(
      "$hostApiAddress/cart/checkout",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      ),
      data: formData,
    );
    String snapToken = response.data['data']['snap_token'] as String;
    log(snapToken);
    checkoutResponse =
        CheckoutResponse(error: false, message: "success", token: snapToken);
  } on DioException catch (e) {
    log(e.response.toString());
    checkoutResponse = CheckoutResponse(
        error: true, message: "internal server error", token: null);
  }
  return checkoutResponse;
}
