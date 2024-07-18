import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:md_customer/exceptions/general_exception.dart';
import 'package:md_customer/http/timeoutClient.dart';
import 'package:md_customer/register/model/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:md_customer/register/views/register.dart';
import 'package:md_customer/values/values.dart';

class RegisterRepository {
  Future<RegisterModel> register(
      String fullName, String phone, String email, String password) async {
    final body = jsonEncode({
      "fullName": fullName,
      "phoneNumber": phone,
      "email": email,
      "password": password
    });
    final headers = {"Content-type": "application/json"};
    final url = "http://$ip:8080/passenger/register";
    TimeoutHttpClient client =
        TimeoutHttpClient(http.Client(), timeout: Duration(seconds: 10));
    try {
      final response =
          await client.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 201) {
        return RegisterModel(statusCode: 201);
      } else if (response.statusCode == 500) {
        return RegisterModel(statusCode: 500, message: response.body);
      } else if (response.statusCode == 409) {
        Map<String, dynamic> decoded = jsonDecode(response.body);
        return RegisterModel(
            statusCode: response.statusCode,
            message: decoded['message'],
            responseType: decoded['responseType']);
      } else if (response.statusCode == 404) {
        return RegisterModel(statusCode: 404);
      } else {
        return RegisterModel(
            statusCode: response.statusCode, message: response.body);
      }
    } on TimeoutException {
      throw GeneralException("Request Time Out! Please Try Again!");
    } on SocketException {
      throw GeneralException("Check your Internet Connection!");
    } catch (e) {
      print(e);
      throw GeneralException("Client: Something Went Wrong!");
    }
  }
}
