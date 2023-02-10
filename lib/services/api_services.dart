//
// Create a project for android and ios. Use your best practice
// to manage authentication with dummy creds. You need to update
// profile screens and update the user details and need to make sure
// only authenticated users can update the profile. Use your imagination
// and http package to handle failure and success.
//
//
// Base usr- example.com
// Jwt token- kasdf9a9sduKJH989
//
//
// auth/v1/login
// {
// “email”:”only gmail”
// “password”:”password”
// }
// Message-{
// "statusCode": 200,
// "error": "",
// "message": "Success Login"
// “Data”:{
// tkn:”kasdf9a9sduKJH989”
// }
// }
//
//
// Message -{
// "statusCode": 400,
// "error": "Bad Request",
// "Message":”Invalid Email or Password”
// }
// Update profile body- users/me
// {
// "password":"",
// "first_name":"",
// ":””
// }last_name":"",
// // "image_url"
//
//
//
//
// Message-{
// "statusCode": 200,
// "error": "",
// "message": "Success updated"
// }
//
//
// Message -{
// "statusCode": 400,
// "error": "Bad Request",
// "Message":”Token Expired”
// }
//
//
//
//
//
//
// Failure Message - {
// "statusCode": 401,
// "error": "Unauthorized",
// "message": "Unauthorized access"
// }

import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../controller/api_service__controller.dart';
import '../features/authentication/models/auth_model.dart';

class ApiServices {
  final String baseUrl = 'example.com';
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<ApiControler<bool>> authenticate(AuthModel auth) async {
    try {
      final Uri url = Uri.parse(baseUrl + "auth/v1/login");

      final header = {
        "content-type": "application/json",
      };

      final body = jsonEncode(auth.toJson());

      // final response = await http.post(url, body: body, headers: header);

      final message;

      if (auth.email == "onlygmail.com" && auth.password == "password") {
        message = {
          "statusCode": 200,
          "error": "",
          "message": "Success Login",
          "data": {
            "tkn": "kasdf9a9sduKJH989",
          }
        };
      } else {
        message = {
          "statusCode": 400,
          "error": "Bad Request",
          "message": "Invalid Email or Password",
        };
      }
      ;

      if (message["statusCode"] == 200) {
        final token = message["data"]["tkn"].toString();
        storage.write(key: "token", value: token);
        return ApiControler<bool>(data: true, message: message["message"]);
      } else {
        return ApiControler<bool>(
            data: false, error: true, message: message["message"]);
      }
    } on SocketException {
      return ApiControler<bool>(
          data: false, error: true, message: "no internet");
    } catch (e) {
      return ApiControler<bool>(
          data: false, error: true, message: "Error Occured");
    }
  }
}
