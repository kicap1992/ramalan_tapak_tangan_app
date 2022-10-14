import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class ApiServices {
  static final dev = Logger();
  static final url = dotenv.env['URL'];
  // static final url = "http://192.168.218.21:9000/";

  static final options = BaseOptions(
    baseUrl: url!,
    connectTimeout: 120000,
    receiveTimeout: 120000,
  );

  static Dio dio = Dio(options);

  static Future<Map?> cekFoto(String? path) async {
    dev.i("ini url $url");
    if (path == null) return null;
    try {
      var formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          path,
          filename: basename(path),
          contentType: MediaType('image', 'jpg'),
        ),
      });
      var response = await dio.post('', data: formData);
      var data = response.data;
      dev.i(data);
      return {
        "status": 200,
        "message": data['message'],
      };
    } on DioError catch (e) {
      dev.e(e.response);
      // return "Tidak dapat terhubung ke database";
      if (e.response == null) {
        return {
          "status": 500,
          "message": "Tidak Dapat Terhubung Ke Database",
        };
      }
      if (e.response!.statusCode == 404) {
        return {
          "status": e.response!.statusCode,
          "message": e.response!.data['detail'],
        };
      }
      return null;
    } catch (e) {
      dev.e(e);
      return {
        "status": 500,
        "message": "Tidak Dapat Terhubung Ke Database",
      };
    }
  }

  static Future<Map?> cekRamalan(String? name) async {
    if (name == null) return null;
    try {
      var formData = FormData.fromMap({
        'image': basename(name),
      });
      var response = await dio.post('ramalan', data: formData);
      var data = response.data;
      dev.i(data);
      return {
        "status": 200,
        "message": data['message'],
        // "message": "Ini ramalannya",
      };
    } on DioError catch (e) {
      dev.e(e.response);
      // return "Tidak dapat terhubung ke database";
      if (e.response == null) {
        return {
          "status": 500,
          "message": "Tidak Dapat Terhubung Ke Database",
        };
      }
      if (e.response!.statusCode == 404) {
        return {
          "status": e.response!.statusCode,
          "message": e.response!.data['detail'],
        };
      }
      return null;
    } catch (e) {
      dev.e(e);
      return {
        "status": 500,
        "message": "Tidak Dapat Terhubung Ke Database",
      };
    }
  }
}
