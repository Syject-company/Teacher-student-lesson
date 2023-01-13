import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:tutor/utils/model/api_model.dart';
import 'package:tutor/utils/model/login/login_model.dart';

import '../utils/model/user_model.dart';

final _base = "http://tutoronhandapi-dev.us-east-1.elasticbeanstalk.com";
final _tokenParentURL = _base + "/api/ParentIdentity/AppLogin/";
final _tokenChildURL = _base + '/api/ChildIdentity/AppLogin/';
final _registerParentURL = _base + "/api/ParentIdentity/Register/";
final _refreshTokenURL = _base + "/api/ParentIdentity/Refresh/";
final _registerChildURL = _base + "/parent/ChildUser/Create/";
final _codeForParentURL =
    _base + "/api/ParentIdentity/VerificationCodeToEmail/";
final _codeForChildURL = _base + "/api/ChildIdentity/VerificationCodeToEmail/";
final _recoveryParentEmailURL = _base + "/api/ParentIdentity/ForgotPassword/";
final _recoveryChildEmailURL = _base + "/api/ChildIdentity/ForgotPassword/";
final _loginURL = _base + '/api/ParentIdentity/SocialLogin';

Future<Token> getToken(UserLogin userLogin, bool isParent) async {
  final http.Response response = await http.post(
    (isParent) ? Uri.parse(_tokenParentURL) : Uri.parse(_tokenChildURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  print(jsonEncode(userLogin.toDatabaseJson()));
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else if (response.statusCode == 500) {
    throw 'Server Error';
  } else {
    print(response.body);
    var resp = json.decode(response.body);

    throw resp['errors'][0]['message'];
  }
}

Future<String?> createUser(UserRegister userRegister) async {
  print('222${jsonEncode(userRegister.toDatabaseJson())}');
  final http.Response response = await http.post(
    Uri.parse(_registerParentURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(userRegister.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return response.body;
  } else {
    final jsonString = response.body.toString();

    Map<String, dynamic> msg = jsonDecode(jsonString);

    return msg.toString();
  }
}

Future<Token> refreshTkn(accessToken, refreshToken) async {
  final http.Response response = await http.post(Uri.parse(_refreshTokenURL),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken; charset=UTF-8',
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
          {"accessToken": "$accessToken", "refreshToken": "$refreshToken"}));

  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else if (response.statusCode == 500) {
    throw 'Server Error';
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<String?> createChild(ChildRegister childRegister, accessToken) async {
  final http.Response response = await http.post(
    Uri.parse(_registerChildURL),
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken",
    },
    body: jsonEncode(childRegister.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return null;
  } else if (response.statusCode == 500) {
    throw 'Server Error';
  }
  final jsonString = response.body.toString();

  Map<String, dynamic> msg = jsonDecode(jsonString);

  return msg.toString();
}

Future<String?> sendNewPass(
    String newPassword, String email, String code, int parentIndex) async {
  final http.Response response = await http.post(
      parentIndex == 0
          ? Uri.parse(_recoveryParentEmailURL)
          : Uri.parse(_recoveryChildEmailURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
          {"recoveryCode": code, "email": email, "newPassword": newPassword}));
  print(jsonEncode(
      {"recoveryCode": code, "email": email, "newPassword": newPassword}));

  print(parentIndex == 0
      ? Uri.parse(_recoveryParentEmailURL)
      : Uri.parse(_recoveryChildEmailURL));
  print('resp${response.statusCode}');
  if (response.statusCode == 200) {
    return null;
  } else if (response.statusCode == 500) {
    throw 'Server Error';
  } else {
    var resp = json.decode(response.body);

    throw resp['errors'][0]['message'];
  }
}

Future<String?> getForgotPassLetter(String email, parentIndex) async {
  final http.Response response = await http.post(
    parentIndex == 0
        ? Uri.parse(_codeForParentURL + '?email=$email')
        : Uri.parse(_codeForChildURL + '?email=$email'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );

  if (response.statusCode == 200) return null;

  return response.body.toString();
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  @override
  String toString() {
    return message;
  }
}

Future<User> sendSocialLoginToken(LoginModel model) async {

  final http.Response response = await http.post(
    Uri.parse(_loginURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(model),
  );

  if (response.statusCode == 200) {
    return User.fromDatabaseJson(json.decode(response.body));
    //return LoginModel();
    //return LoginModel.fromJson(json.decode(response.body));
  } else if (response.statusCode == 500) {
    throw 'Server Error';
  } else {
    print(response.body);
    var resp = json.decode(response.body);

    throw resp['errors'][0]['message'];
  }
}
