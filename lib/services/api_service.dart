import 'package:dio/dio.dart';
import 'package:movies_app/app/app.locator.dart';
import 'package:movies_app/config/config.dart';
import 'package:movies_app/models/request_response.dart';
import 'package:stacked/stacked.dart';

/// ApiService
///
///
class ApiService with ListenableServiceMixin {
  ///launch dio, get, post, put, delete methods here
  final _config = locator<Config>();

  ///launchDio
  Future<Dio> launchDio() async {
    // String? accessToken = locator<LocalStorageService>().accessToken;
    // log.d(accessToken);
    Dio dio = Dio();

    ///
    ///interceptors for log and api response , request and error
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    // dio.interceptors.add(TokenInterceptor(dio));
    dio.options.baseUrl = _config.baseUrl;
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['accept'] = 'application/json';
    // dio.options.headers['Authorization'] = 'Bearer $accessToken';
    dio.options.followRedirects = false;
    dio.options.validateStatus = (s) {
      if (s != null) {
        return s < 500;
      } else {
        return false;
      }
    };
    return dio;
  }

  get({required String endPoint, params}) async {
    Dio dio = await launchDio();
    try {
      final response = await dio.get(
        '${_config.baseUrl}/$endPoint',
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        // print("response.data is ${response}");
        return response;
      } else {
        return RequestResponse(false, {}, error: response.statusMessage);
      }
    } catch (e) {
      return RequestResponse(false, {}, error: 'Error');
    }
  }

  post({required String endPoint, data}) async {
    Dio dio = await launchDio();
    try {
      final response =
          await dio.post('${_config.baseUrl}/$endPoint', data: data);

      if (response.statusCode == 200) {
        return RequestResponse.fromJson(response.data);
      } else {
        return RequestResponse(false, {}, error: response.statusMessage);
      }
    } catch (e) {
      return RequestResponse(false, {}, error: 'Error');
    }
  }

  put({required String endPoint, data, params}) async {
    Dio dio = await launchDio();
    try {
      final response = await dio.put('${_config.baseUrl}/$endPoint',
          data: data, queryParameters: params);
      if (response.statusCode == 200) {
        return RequestResponse.fromJson(response.data);
      } else {
        return RequestResponse(false, {}, error: response.statusMessage);
      }
    } catch (e) {
      return RequestResponse(false, {}, error: 'Error');
    }
  }

  delete({required String endPoint, params, data}) async {
    Dio dio = await launchDio();
    try {
      final response = await dio.delete('${_config.baseUrl}/$endPoint',
          data: data, queryParameters: params);

      if (response.statusCode == 200) {
        return RequestResponse.fromJson(response.data);
      } else {
        return RequestResponse(false, {}, error: response.statusMessage);
      }
    } catch (e) {
      return RequestResponse(false, {}, error: 'Error');
    }
  }
}
