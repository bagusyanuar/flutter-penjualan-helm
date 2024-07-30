import 'dart:developer';

import 'package:app_sadean_helm/controller/util.dart';
import 'package:dio/dio.dart';

class RegisterResponse {
  bool error;
  String message;
  String accessToken;

  RegisterResponse({
    required this.error,
    required this.message,
    required this.accessToken,
  });
}

Future<RegisterResponse> registerHandler(Map<String, String> data) async {
  RegisterResponse registerResponse = RegisterResponse(
    error: true,
    message: 'internal server error',
    accessToken: '',
  );
  try {
    var formData = FormData.fromMap(data);
    final response = await Dio().post("$hostApiAddress/register",
        options: Options(headers: {"Accept": "application/json"}),
        data: formData);
    final int status = response.data["status"] as int;
    final String message = response.data["message"] as String;
    log(response.toString());
    if (status == 200) {
      final String token = response.data["data"]["access_token"] as String;
      registerResponse = RegisterResponse(
        error: false,
        message: 'success',
        accessToken: token,
      );
    } else {
      log("Login Failed");
      registerResponse = RegisterResponse(
        error: true,
        message: 'internal server error',
        accessToken: '',
      );
    }
  } on DioException catch (e) {
    log("Error ${e.response}");
    registerResponse = RegisterResponse(
      error: true,
      message: 'internal server error',
      accessToken: '',
    );
  }
  return registerResponse;
}
