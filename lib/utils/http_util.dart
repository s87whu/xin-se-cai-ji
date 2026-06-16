import 'dart:async';

import 'package:dio/dio.dart';

/// HTTP请求工具
class HttpUtil {
  late final Dio _dio;

  HttpUtil() {
    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
    ));
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? parameters,
    ResponseType type = ResponseType.json,
  }) async {
    return await _dio.get(
      url,
      queryParameters: parameters,
      options: Options(responseType: type),
    );
  }

  Future<Response> post(
    String url, {
    Map<String, String>? header,
    dynamic data,
  }) async {
    return await _dio.post(
      url,
      data: data,
      options: Options(headers: header),
    );
  }

  Future<Stream<String>?> postStream(
    String url, {
    Map<String, String>? header,
    dynamic data,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: header,
          responseType: ResponseType.stream,
        ),
      );
      final stream = response.data?.stream as Stream<List<int>>?;
      if (stream == null) return null;
      return stream.transform(
        StreamTransformer.fromHandlers(
          handleData: (data, sink) {
            sink.add(String.fromCharCodes(data));
          },
        ),
      );
    } catch (e) {
      return null;
    }
  }
}
