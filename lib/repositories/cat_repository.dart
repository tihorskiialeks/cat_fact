import 'package:dio/dio.dart';


import '../api_service/api_service.dart';
import '../entities/cat.dart';

class CatRepository {
  final ApiClient _apiclient = ApiClient(Dio());
  Future<Cat> getCatInfo() async {
    final String response = await _apiclient.fetchData();

    return Cat.fromJson(response);
  }
}
