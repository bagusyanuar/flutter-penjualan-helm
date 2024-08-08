import 'dart:developer';

import 'package:app_sadean_helm/controller/util.dart';
import 'package:app_sadean_helm/model/order.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderSuccessResponse {
  bool error;
  String message;

  OrderSuccessResponse({
    required this.error,
    required this.message,
  });
}

class OrderListResponse {
  bool error;
  String message;
  List<Order> data;

  OrderListResponse({
    required this.error,
    required this.message,
    required this.data,
  });
}

class OrderByIDResponse {
  bool error;
  String message;
  OrderDetail? data;

  OrderByIDResponse({
    required this.error,
    required this.message,
    required this.data,
  });
}

Future<OrderSuccessResponse> orderSuccessHandler(String id) async {
  OrderSuccessResponse orderSuccessResponse = OrderSuccessResponse(
    error: true,
    message: "internal server error",
  );
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("token");
    final response = await Dio().post(
      "$hostApiAddress/order/$id",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      ),
    );
    log(response.data.toString());
    orderSuccessResponse = OrderSuccessResponse(
      error: false,
      message: "success",
    );
  } on DioException catch (e) {
    orderSuccessResponse = OrderSuccessResponse(
      error: true,
      message: "internal server error",
    );
  }
  return orderSuccessResponse;
}

Future<OrderListResponse> getOrderListHandler() async {
  OrderListResponse orderListResponse = OrderListResponse(
    error: true,
    message: "internal server error",
    data: [],
  );
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("token");
    final response = await Dio().get(
      "$hostApiAddress/order",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      ),
    );
    List<dynamic> orderData = response.data['data'];
    log(orderData.toString());
    List<Order> data = orderData.map((e) => Order.fromJson(e)).toList();
    orderListResponse = OrderListResponse(
      error: false,
      message: "success",
      data: data,
    );
  } on DioException catch (e) {
    log(e.response.toString());
    orderListResponse = OrderListResponse(
      error: true,
      message: "internal server error",
      data: [],
    );
  }
  return orderListResponse;
}

Future<OrderByIDResponse> getOrderByID(int id) async {
  OrderByIDResponse orderByIDResponse = OrderByIDResponse(
      error: true, message: "internal server error", data: null);
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("token");
    final response = await Dio().get(
      "$hostApiAddress/order/9",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      ),
    );
    log(response.data.toString());
    dynamic dataOrder = response.data['data'] as dynamic;

    if (dataOrder != null) {
      OrderDetail tmpDataOrder = OrderDetail.fromJson(dataOrder);
      orderByIDResponse = OrderByIDResponse(
          error: false, message: "success", data: tmpDataOrder);
    }
    log(response.data.toString());
  } on DioException catch (e) {
    orderByIDResponse = OrderByIDResponse(
        error: true, message: "internal server error", data: null);
  }
  return orderByIDResponse;
}
