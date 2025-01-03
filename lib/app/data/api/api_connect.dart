import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:live_admin/app/controllers/storage_controller.dart';
import 'package:live_admin/app/data/api/api_error.dart';
import 'package:live_admin/app/modules/auth_module/controllers/login_model.dart';
import 'package:live_admin/app/modules/home/movies/models/add_movie_model.dart';
import 'package:live_admin/app/utils/constants.dart';

class ApiConnect extends GetConnect {
  static final ApiConnect instance = ApiConnect._();
  dynamic _reqBody;

  ApiConnect._() {
    baseUrl = EndPoints.baseUrl;
    logPrint = print;
    timeout = EndPoints.timeout;

    httpClient.addRequestModifier<dynamic>((request) {
      logPrint('************** Request **************');
      _printKV('uri', request.url);
      _printKV('method', request.method);
      _printKV('followRedirects', request.followRedirects);
      logPrint('headers:');
      request.headers.forEach((key, v) => _printKV(' $key', v.toString()));
      logPrint('data:');
      if (_reqBody is Map) {
        _reqBody?.forEach((key, v) => _printKV(' $key', v.toString()));
      } else {
        _printAll(_reqBody.toString());
      }
      logPrint('*************************************');
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      logPrint('************** Response **************');
      _printKV('uri', response.request!.url);
      _printKV('statusCode', response.statusCode!);
      if (response.headers != null) {
        logPrint('headers:');
        response.headers?.forEach((key, v) => _printKV(' $key', v.toString()));
      }
      logPrint('Response Text:');
      _printAll(response.bodyString);
      logPrint('*************************************');
      return response;
    });
  }

  late void Function(Object object) logPrint;

  @override
  Future<Response<T>> get<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) {
    _checkIfDisposed();

    Map<String, String> headers0 = headers ?? <String, String>{};
    // _headers["Authorization"] = "Bearer " + HiveAdapter.getAccessToken();

    _reqBody = query;
    return httpClient.get<T>(
      url,
      headers: headers0,
      contentType: contentType,
      query: query,
      decoder: decoder,
    )..whenComplete(() => _reqBody = null);
  }

  @override
  Future<Response<T>> delete<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) {
    _checkIfDisposed();

    Map<String, String> headers0 = headers ?? <String, String>{};
    // _headers["Authorization"] = "Bearer " + HiveAdapter.getAccessToken();

    _reqBody = query;
    return httpClient.delete<T>(
      url,
      headers: headers0,
      contentType: contentType,
      query: query,
      decoder: decoder,
    )..whenComplete(() => _reqBody = null);
  }

  @override
  Future<Response<T>> post<T>(
    String? url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    _checkIfDisposed();

    Map<String, String> headers0 = headers ?? <String, String>{};
    // _headers["Authorization"] = "Bearer " + HiveAdapter.getAccessToken();
    try {
      _reqBody = body;
    } catch (e) {
      // print(e.toString());
    }

    return httpClient.post<T>(
      url,
      body: body,
      headers: headers0,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    )..whenComplete(() => _reqBody = null);
  }

  @override
  Future<Response<T>> put<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    _checkIfDisposed();

    Map<String, String> headers0 = headers ?? <String, String>{};
    // _headers["Authorization"] = "Bearer " + HiveAdapter.getAccessToken();

    _reqBody = body;

    return httpClient.put<T>(
      url,
      body: body,
      headers: headers0,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    )..whenComplete(() => _reqBody = null);
  }

  void _printKV(String key, Object v) {
    logPrint('$key: $v');
  }

  void _printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }

  void _checkIfDisposed() {
    if (isDisposed) {
      throw 'Can not emit events to disposed clients';
    }
  }

  // auth header
  Future<Map<String, String>> authHeader() async {
    return {
      "Authorization": "Bearer ${await SC.to.getToken()}",
      "Accept": "application/json",
    };
  }
// login

  Future<LoginModel> login(String email, String password) async {
    final body = {
      'email': email,
      'password': password,
    };

    try {
      _reqBody = body;
      final response = await post(EndPoints.login, jsonEncode(body));
      SC.to.saveUser(LoginModel.fromJson(response.body));
      return LoginModel.fromJson(response.body);
    } finally {
      _reqBody = null;
    }
  }

  // add movie
  Future<Response> addMovie(AddMovie mov) async {
    try {
      final res = await post(EndPoints.addMovie, mov.toJson(),
          headers: await authHeader());
      log("Response ${res.body}");
      return res;
    } catch (e) {
      return Response(body: e.toString());
    }
  }
}

extension ResErr<T> on Response<T> {
  T getBody() {
    if (status.connectionError) {
      throw NoConnectionError();
    }

    if (status.isUnauthorized) {
      throw UnauthorizedError();
    }

    if (status.code == HttpStatus.badRequest) {
      final res = jsonDecode(bodyString!);
      throw ServerResError(res.toString());
    }

    if (status.code == HttpStatus.requestTimeout) {
      throw TimeoutError();
    }

    if (!status.isOk) {
      throw UnknownError();
    }

    try {
      final res = jsonDecode(bodyString!);

      if (res is Map && res['valid'] != null && !res['valid']) {
        throw ServerResError(res['message']);
      }

      return body!;
    } on TimeoutException catch (_) {
      throw TimeoutError();
    } catch (_) {
      throw UnknownError();
    }
  }
}
