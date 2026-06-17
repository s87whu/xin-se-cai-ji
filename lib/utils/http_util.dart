import 'dart:async';
import 'dart:convert';

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
      final rawStream = response.data?.stream as Stream<List<int>>?;
      if (rawStream == null) return null;
      // 将原始字节流转为 SSE 事件流：按 \n\n 缓冲，提取 data: 行
      return rawStream
          .transform(const Utf8Decoder(allowMalformed: true))
          .transform(const LineSplitter())
          .transform<String>(
            StreamTransformer<String, String>.fromHandlers(
              handleData: (line, sink) {
                // 每个 SSE 事件以空行分隔，data: 行携带数据
                if (line.startsWith('data: ')) {
                  sink.add(line.substring(6));
                }
                // 忽略 event:、id:、retry: 等其他 SSE 字段
              },
            ),
          );
    } catch (e) {
      return null;
    }
  }
}
