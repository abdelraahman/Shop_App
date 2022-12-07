import 'package:dio/dio.dart';

class DioHelper {
    static late Dio dio;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: "https://newsapi.org/",
        receiveDataWhenStatusError: true,
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType:ResponseType.json,

      ),
    );
  }
   static Future<Response> getData()async
  {
    return await dio.get('v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca');
  }
}