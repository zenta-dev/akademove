import 'dart:convert';
import 'package:akademove/core/_export.dart';
import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('''
🚀 REQUEST
[${options.method}] ${options.uri}

Headers:
${_prettyMap(options.headers)}

Query Parameters:
${_prettyMap(options.queryParameters)}

Data:
${_stringify(options.data)}
''');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    logger.d('''
✅ RESPONSE
[${response.requestOptions.method}] ${response.requestOptions.uri}

Status Code: ${response.statusCode}

Headers:
${_prettyMap(response.headers.map)}

Data:
${_stringify(response.data)}
''');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e('''
❌ ERROR
[${err.requestOptions.method}] ${err.requestOptions.uri}

Type: ${err.type}
Message: ${err.message}

Response:
${_stringify(err.response?.data)}
''');
    super.onError(err, handler);
  }

  String _prettyMap(Map? map) {
    if (map == null || map.isEmpty) return '{}';
    return map.entries.map((e) => '  ${e.key}: ${e.value}').join('\n');
  }

  String _stringify(dynamic data) {
    try {
      if (data == null) return 'null';
      if (data is Map || data is List) {
        return const JsonEncoder.withIndent('  ').convert(data);
      }
      return data.toString();
    } catch (_) {
      return data.toString();
    }
  }
}
