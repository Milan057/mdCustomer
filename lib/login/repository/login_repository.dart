import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:md_customer/exceptions/general_exception.dart';
import 'package:md_customer/login/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:md_customer/http/timeoutClient.dart';
import 'package:md_customer/login/views/login.dart';
import 'package:md_customer/values/values.dart';

class LoginRepository {
  Future<LoginModel> login(String email, String password) async {
    final body = jsonEncode({'email': email, 'password': password});

    final headers = {"Content-type": "application/json"};
    const url = "http://$ip:8080/busAdmin/login";
    TimeoutHttpClient client =
        TimeoutHttpClient(http.Client(), timeout: Duration(seconds: 10));

    try {
      final response =
          await client.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        return LoginModel(statusCode: 200, token: response.body);
      } else if (response.statusCode == 400) {
        return LoginModel(statusCode: 400, message: response.body);
      } else {
        return LoginModel(
            statusCode: response.statusCode, message: response.body);
      }
    } on TimeoutException catch (e) {
      throw GeneralException("Request Time Out! Please Try Again!");
    } on SocketException catch (e) {
      throw GeneralException("Please Check your Internet Connection");
    } catch (e) {
      print(e);
      throw GeneralException("Something Went Wrong!");
    }
  }
}
