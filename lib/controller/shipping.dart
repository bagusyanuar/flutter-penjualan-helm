import 'dart:developer';

import 'package:app_sadean_helm/controller/util.dart';
import 'package:app_sadean_helm/model/shipping.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShippingResponse {
  bool error;
  String message;
  List<Shipping> data;

  ShippingResponse({
    required this.error,
    required this.message,
    required this.data,
  });
}

Future<ShippingResponse> fetchShippingList() async {
  ShippingResponse shippingResponse = ShippingResponse(
    error: true,
    message: "internal server error",
    data: [],
  );
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("token");
    final response = await Dio().get("$hostApiAddress/shipping",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ));
    log(response.data.toString());
    List<dynamic> shippingData = response.data['data'];
    List<Shipping> data =
        shippingData.map((e) => Shipping.fromJson(e)).toList();
    shippingResponse = ShippingResponse(
      error: false,
      message: "success",
      data: data,
    );
  } on DioException catch (e) {
    log("Error ${e.response}");
    shippingResponse = ShippingResponse(
      error: true,
      message: "internal server error",
      data: [],
    );
  }
  return shippingResponse;
}
