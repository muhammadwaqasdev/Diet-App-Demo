import 'package:diet_app/src/models/foods_reponse.dart';
import 'package:diet_app/src/services/remote/api_client.dart';
import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}

class ApiService {
  ApiClient? _apiClient;
  late Dio dio;

  ApiService() {
    dio = Dio();
    _apiClient = ApiClient(dio, interceptors: [AppInterceptor()]);
  }

  Future<List<Food>?> getFoods(String query,
      {CancelToken? cancelToken,
      int page = 0,
      double minCalorieLimit = 0,
      List<int> dislikedMeals = const []}) async {
    try {
      dio.clear();
      var params = {
        "query": query,
        "page": page,
        "min_calorie": minCalorieLimit
      };
      if (dislikedMeals.isNotEmpty) {
        params["not_included"] = dislikedMeals.join(",");
      }
      var response =
          await _apiClient?.get('', params: params, cancelToken: cancelToken);
      if (!(response?.data is List<dynamic>?)) {
        return [];
      }
      return (response?.data as List<dynamic>?)
          ?.map((e) => Food.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
    }
  }
}
