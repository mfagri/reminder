import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:remindly/services/local_storage.dart';

final dio = Dio();
String? apiUrl = dotenv.env['API_URL'];

class AuthServer {
  static Future<dynamic> login(String email, String password) async {
    try {
      final response = await dio.post('$apiUrl/users/login',
          data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<dynamic> register(
      String name, String email, String password, String image) async {
    try {
      final response = await dio.post(
        '$apiUrl/users/signup',
        data: {
          'email': email,
          'password': password,
          'name': name,
          "image": image,
        },
      );
      if (response.statusCode == 201) {
        return response.data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  //get profile
  static Future<dynamic> getProfile() async {
    String? token = await LocalStorage.getToken();
    try {
      final response = await dio.get('$apiUrl/users/me',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  //update profile
  static Future<dynamic> updateProfile(String name, String email) async {
    String? token = await LocalStorage.getToken();
    try {
      final response = await dio.put('$apiUrl/users/update',
          data: {'name': name, 'email': email},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  //update password
  static Future<dynamic> updatePassword(String oldPassword,newPassword) async {
    String? token = await LocalStorage.getToken();
    try {
      final response = await dio.put('$apiUrl/users/update-password',
          data: {'oldPassword': oldPassword, 'newPassword': newPassword},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
