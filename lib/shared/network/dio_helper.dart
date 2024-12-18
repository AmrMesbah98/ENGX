import 'package:dio/dio.dart';

class DioHelperPayment {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://accept.paymob.com/api/",
        receiveDataWhenStatusError: true));
  }

//=======================================================================================================================================================

  static Future<Response> getData(
      {required url, Map<String, dynamic>? query}) async {
    dio.options.headers = {'Content-Type': 'application/json'};
    return await dio.get(url, queryParameters: query);
  }

//=======================================================================================================================================================

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data}) async {
    return await dio.post(url, data: data, queryParameters: query,options: Options (
      validateStatus: (_) => true,
    ));
  }
}
