import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  ApiService(this._dio);
  Future<Response> postData( {Map<String, dynamic>? query,required Map<String, dynamic> data,String lang = 'en',String? token})async {
    _dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization':'key=AAAAk1TWIg8:APA91bGVl00awmI7MndzyyaOjmp7_4odtVEG8yhWPGyb1gznSmG0UrbsZCtVZ7TYbUraUF9-FOPDNzoe5S4B30AeCwFv7-WgWuywaAcEfZDH5R_8astX-5W2NFADL5zKiRHFclv3nUtk'
    };
    return await _dio.post('https://fcm.googleapis.com/fcm/send', queryParameters: query, data: data);
  }
}




