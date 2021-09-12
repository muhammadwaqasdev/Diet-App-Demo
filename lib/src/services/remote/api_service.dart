import 'package:diet_app/src/models/foods_reponse.dart';
import 'package:dio/dio.dart';
import 'package:diet_app/src/services/remote/api_client.dart';

class ApiService {
  ApiClient? _apiClient;
  late Dio dio;

  ApiService() {
    dio = Dio();
    _apiClient = ApiClient(dio);
  }

  Future<FoodsResponse?> getFoods(String query, CancelToken cancelToken,
      {int page = 0}) async {
    try {
      dio.clear();
      var response = await _apiClient?.get('',
          params: {"query": query, "page": page}, cancelToken: cancelToken);
      return FoodsResponse.fromJson(response?.data);
    } catch (e) {
      print(e);
    }
  }
}
