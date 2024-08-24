import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:remindly/services/local_storage.dart';

class FriendServer {
  static final dio = Dio();
  static String? apiUrl = dotenv.env['API_URL'];

  //search user

  static Future<dynamic> searchUser(String name) async {
    String? token = await LocalStorage.getToken();
    try {
      final response = await dio.get('$apiUrl/friends/search?name=$name',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  //add friend
  static Future<dynamic> addFriend(String id) async {
    try {
      final response = await dio.post('$apiUrl/friends/add-friend/',
          options: Options(headers: {
            'Authorization': 'Bearer ${await LocalStorage.getToken()}'
          }),
          data: {'friendId': id});

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  //get friends
  static Future<dynamic> getFriends() async {
    try {
      final response = await dio.get('$apiUrl/friends/friends',
          options: Options(headers: {
            'Authorization': 'Bearer ${await LocalStorage.getToken()}'
          }));
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
