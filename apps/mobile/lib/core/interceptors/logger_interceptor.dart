import 'dart:developer';
import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('''
================= 🚀 REQUEST =================
[${options.method}] ${options.uri}

Headers:
${options.headers}

Query Parameters:
${options.queryParameters}

Data:
${options.data}

==============================================
''');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    log('''
================= ✅ RESPONSE =================
[${response.requestOptions.method}] ${response.requestOptions.uri}

Status: ${response.statusCode}

Headers:
${response.headers.map}

Data:
${response.data}

===============================================
''');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('''
================= ❌ ERROR =================
[${err.requestOptions.method}] ${err.requestOptions.uri}

Type: ${err.type}
Message: ${err.message}

Response: ${err.response?.data}

============================================
''');
    super.onError(err, handler);
  }
}
