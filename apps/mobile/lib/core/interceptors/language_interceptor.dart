import 'package:akademove/core/services/kv_service.dart';
import 'package:dio/dio.dart';
import 'package:intl/locale.dart';

class AcceptLanguageInterceptor extends Interceptor {
  AcceptLanguageInterceptor(this.kv);
  final KeyValueService kv;
  String? _cached;

  Future<String?> _getLang() async {
    if (_cached != null) return _cached;

    final localeTag = await kv.get<String>(KeyValueKeys.locale);

    if (localeTag != null) {
      final locale = Locale.parse(localeTag);
      _cached = locale.toLanguageTag();
    }

    return _cached;
  }

  void updateCached(String lang) {
    _cached = lang;
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final lang = await _getLang();
    if (lang != null) {
      options.headers['Accept-Language'] = lang;
    }
    handler.next(options);
  }
}
