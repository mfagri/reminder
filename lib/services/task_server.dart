import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:remindly/services/local_storage.dart';

final dio = Dio();
String? apiUrl = dotenv.env['API_URL'];

class TaskServer {
  static Future<dynamic> getTasks() async {
    String? token = await LocalStorage.getToken();
    try {
      final response = await dio.get('$apiUrl/tasks/tasks',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> createTask(String title, String description,
      String date, String id, int remindertime) async {
    try {
      String? token = await LocalStorage.getToken();
      final response = await dio.post('$apiUrl/tasks/tasks',
          data: {
            "name": title,
            "description": description,
            "startDate": date,
            "reminderTime": remindertime, // In minutes
            "status": "pending",
            "assignedTo": id
          },
          options: Options(
              headers: {'Authorization': 'Bearer ${token.toString()}'}));
      if (response.statusCode == 201) {
        return response.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
