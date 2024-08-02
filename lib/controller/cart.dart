import 'dart:developer';

import 'package:app_sadean_helm/controller/util.dart';
import 'package:app_sadean_helm/model/cart.dart';
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
  String? orderID;

  CheckoutResponse({
    required this.error,
    required this.message,
    required this.token,
    required this.orderID,
  });
}

class CartListResponse {
  bool error;
  String message;
  List<Cart> data;

  CartListResponse(
      {required this.error, required this.message, required this.data});
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
      error: true, message: "internal server error", token: null, orderID: '');
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
    int orderID = response.data['data']['order_id'] as int;
    log(snapToken);
    checkoutResponse = CheckoutResponse(
        error: false,
        message: "success",
        token: snapToken,
        orderID: orderID.toString());
  } on DioException catch (e) {
    log(e.response.toString());
    checkoutResponse = CheckoutResponse(
        error: true,
        message: "internal server error",
        token: null,
        orderID: '');
  }
  return checkoutResponse;
}

Future<CartListResponse> getCartListHandler() async {
  CartListResponse cartListResponse = CartListResponse(
    error: true,
    message: "internal server error",
    data: [],
  );
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("token");
    final response = await Dio().get(
      "$hostApiAddress/cart",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      ),
    );
    List<dynamic> cartData = response.data['data'];
    log(cartData.toString());
    List<Cart> data = cartData.map((e) => Cart.fromJson(e)).toList();
    cartListResponse = CartListResponse(
      error: false,
      message: "success",
      data: data,
    );
  } on DioException catch (e) {
    log(e.response.toString());
    cartListResponse = CartListResponse(
      error: true,
      message: "internal server error",
      data: [],
    );
  }
  return cartListResponse;
}
