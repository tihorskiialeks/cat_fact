import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../consts/api_consts.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: kApi)
abstract class ApiClient {
  factory ApiClient(final Dio dio, {final String baseUrl}) = _ApiClient;

  @GET('/')
  Future<String> fetchData();
}
