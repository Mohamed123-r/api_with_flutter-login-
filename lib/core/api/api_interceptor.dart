import 'package:dio/dio.dart';

import '../database/cache/cache_helper.dart';
import 'end_point.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    options.headers['token'] =   CacheHelper().getData(key: ApiKeys.token) != null ?
    'FOODAPI ${CacheHelper().getData(key: ApiKeys.token)}' : null;;
  }
}
