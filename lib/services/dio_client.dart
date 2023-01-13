import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tutor/constants/api.dart';
import 'package:tutor/utils/repository/repositories.dart';

class DioClient {
  // TO DO: Get current user token here
  Future<String> getAccessToken() async {
    if (_token.isNotEmpty) return _token;

    var token = await UserRepository().getAccessToken();
    if (token != null) _token = token;
    return _token;
  }

  String _token = "";
  Dio _dio = Dio();
  static String baseUrl = Api.baseUrl;

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.json,
      contentType: 'application/json', // Added contentType here
      connectTimeout: 30000,
      receiveTimeout: 30000,
    ));

    //  initializeInterceptors();
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
        onError: (DioError e, ErrorInterceptorHandler handler) {
      print(e.message);
    }, onRequest: (options, handler) {
      print("Method: ${options.method}");
      print("URI: ${options.uri}");
      print("Data: ${options.data}");
    }, onResponse: (response, handler) {
      print(response.data);
    }));
  }

  Future<Response?> getRequest(String endPoint) async {
    Response response;
    try {
      response = await _dio.get(endPoint);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    print(response.data);
    return response;
  }

  Future<List<dynamic>?> getList(String endPoint) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.get(endPoint);
      return response.data as List;
    } on DioError catch (e) {
      print(e);
    } on Exception catch (e) {
      // Unhandled exception
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getItem(String endPoint) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.get(endPoint);
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print('Error');
      print(e);
      return <String, dynamic>{"_exception": e};
    } on Exception catch (e) {
      // Unhandled exception

      print(e);
      return <String, dynamic>{"_exception": e};
    }
  }

  Future<Map<String, dynamic>> addItem(
      String endPoint, Map<String, dynamic> itemObject) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.post(endPoint, data: itemObject);
      print('Item added ${response.data}');
      return response.data;
    } on DioError catch (e) {
      print(e);
      return <String, dynamic>{"_error": e};
    } on Exception catch (e) {
      // Unhandled exception
      print(e);
      return <String, dynamic>{"_exception": e};
    }
  }

  Future getAndAddItem(String endPoint, String itemObject) async {
    try {
      await addAuthorizationHeader();

      final response = await _dio.get(
        endPoint + itemObject,
      );
      print('Item added ${response.data}');
      return response.data;
    } on DioError catch (e) {
      print(e);
      return e.error;
    } on Exception catch (e) {
      // Unhandled exception
      print(e);
      throw Exception(e);
    }
  }

  Future postPrize(String endPoint, Map<String, dynamic> itemObject) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.post(endPoint, data: itemObject);
      print('Prize claimed ${response}');
      return response.data;
    } on DioError catch (e) {
      print(e);
      throw e;
      // return <String, dynamic>{"_error": e};
    } on Exception catch (e) {
      // Unhandled exception

      print(e);
      throw Exception(e);
      // return <String, dynamic>{"_exception": e};
    }
  }

  Future post(
    String endPoint,
  ) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.post(endPoint);
      print('Prize claimed ${response}');
      return response.data;
    } on DioError catch (e) {
      print(e);
      throw e;
      // return <String, dynamic>{"_error": e};
    } on Exception catch (e) {
      // Unhandled exception

      print(e);
      throw Exception(e);
      // return <String, dynamic>{"_exception": e};
    }
  }

  Future<String> putPrize(
      String endPoint, Map<String, dynamic> itemObject) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.put(endPoint, data: itemObject);
      print('Prize claimed ${response.data}');
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      throw e.response?.data;
      // return <String, dynamic>{"_error": e};
    } on Exception catch (e) {
      // Unhandled exception

      print(e);
      throw Exception(e);
      // return <String, dynamic>{"_exception": e};
    }
  }

  Future<String> getAnswer(
      String endPoint, Map<String, dynamic> itemObject) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.post(endPoint, data: itemObject);
      print('Prize claimed ${response}');
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      throw e.response?.data.values;
      // return <String, dynamic>{"_error": e};
    } on Exception catch (e) {
      // Unhandled exception

      print(e);
      throw Exception(e);
      // return <String, dynamic>{"_exception": e};
    }
  }

  Future<String?> getQrCode(
      String endPoint, Map<String, dynamic> itemObject) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.post(endPoint, data: itemObject);
      print('Prize claimed ${response}');
      if (response.statusCode == 201) {
        return 'Užduotis atlikta';
      }
      return response.statusMessage;
    } on DioError catch (e) {
      print(e.response);
      throw e.response?.data.values;
      // return <String, dynamic>{"_error": e};
    } on Exception catch (e) {
      // Unhandled exception

      print(e);
      throw Exception(e);
      // return <String, dynamic>{"_exception": e};
    }
  }

  Future getUser(String endPoint) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.get(endPoint);
      print('Prize claimed ${response}');
      // return RegUser.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response);
      throw e.response?.data.values;
      // return <String, dynamic>{"_error": e};
    } on Exception catch (e) {
      // Unhandled exception

      print(e);
      throw Exception(e);
      // return <String, dynamic>{"_exception": e};
    }
  }

  Future<Map<String, dynamic>?> updateItem(
      String endPoint, Map<String, dynamic> itemObject) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.patch(endPoint, data: itemObject);
      print('Item updated ${response.data}');
      return response.data;
    } on DioError catch (e) {
      print(e);

      if (e.response?.data is Map<String, dynamic>) {
        Map<String, dynamic> dataMap = e.response?.data as Map<String, dynamic>;
        var errorMessagesList = dataMap.entries.first.value as List<dynamic>;
        return {"error": errorMessagesList.first};
      }
    } on Exception catch (e) {
      // Unhandled exception
      print(e);
    }
  }

  patchItem(String endPoint, Map<String, dynamic> itemObject) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.patch(endPoint, data: itemObject);
      print('Item updated ${response.data}');
      return (response.data);
    } on DioError catch (e) {
      print(e);
    } on Exception catch (e) {
      // Unhandled exception
      print(e);
    }
  }

  patchUser(String endPoint, Map<String, dynamic> itemObject) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.patch(endPoint, data: itemObject);
      print(response.statusMessage);
      return response.statusMessage;
    } on DioError catch (e) {
      print(e);
    } on Exception catch (e) {
      // Unhandled exception
      print(e);
    }
  }

  putNewParentPassword(
      String endPoint, String oldPassword, String newPassword) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.put(
        endPoint,
        data: {"oldPassword": oldPassword, "newPassword": newPassword},
      );
      print(response.data);
      // if (response.statusCode == true) {
      return response.data;
      // } else {
      //   print(json.decode(response.data).toString());
      //   throw Exception(json.decode(response.data));
      // }
    } on DioError catch (error) {
      print(error);
      throw error.error;
    } on Exception catch (e) {
      print(e);
      throw Exception((e));
    }
  }

  Future putUser(String endPoint) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.put(endPoint);
      print('Child putted ${response}');
    } on DioError catch (e) {
      print(e.response);
      throw e.response?.data.values;
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future sendRePassword(
      String endPoint, Map<String, dynamic> itemObject) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.post(endPoint, data: itemObject);
      return response.data;
    } on DioError catch (e) {
      print(e);

      if (e.response?.data is Map<String, dynamic>) {
        Map<String, dynamic> dataMap = e.response?.data as Map<String, dynamic>;
        ;
        return dataMap.toString();
      }
    } on Exception catch (e) {
      // Unhandled exception
      print(e);
    }
  }

  Future<Map<String, dynamic>?> removeItem(
      String endPoint, Map<String, dynamic> itemObject) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.delete(endPoint, data: itemObject);
      print('Item removed ${response.data}');
      return response.data;
    } on DioError catch (e) {
      print(e);
    } on Exception catch (e) {
      // Unhandled exception
      print(e);
    }
  }

  Future remove(String endPoint) async {
    try {
      await addAuthorizationHeader();
      final response = await _dio.delete(endPoint);
      print('Parent removed ${response.data.toString().length}');

      return response.data;
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      // Unhandled exception
      print(e);
    }
  }

  Future<Map<String, dynamic>?> uploadFile(
      String endPoint, File file, String uuid, String challengeType) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
        "concrete_joined_challenge_uuid": uuid,
        "challenge_type": challengeType
      });
      await addAuthorizationHeader();
      var response = await _dio.post(endPoint, data: formData);
      return response.data;
    } on DioError catch (e) {
      print('222');
      // print(e);
      throw (e);
    } on Exception catch (e) {
      print('333');
      print(e);
    }
  }

  Future<void> addAuthorizationHeader() async {
    String token = await _getAccessToken();
    print('get ${token}');
    _dio.options.headers = {"Authorization": "Bearer $token"};
  }

  Future<String> _getAccessToken() async {
    if (_token.isNotEmpty) return _token;

    var token = await UserRepository().getAccessToken();
    if (token != null) _token = token;
    return _token;
  }
}
