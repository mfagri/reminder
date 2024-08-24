import 'package:flutter/material.dart';
import 'package:remindly/model/user.dart';
import 'package:remindly/services/auth_server.dart';
import 'package:remindly/services/local_storage.dart';

class AuthProvider extends ChangeNotifier {
  User? user;
  String? error;
  bool get isLogin => user != null;

  Future login(
    String email,
    String password,
  ) async {
    var data = await AuthServer.login(email, password);
    if (data == null) {
      error = 'Email or password is incorrect';
      notifyListeners();
      return;
    }
    LocalStorage.saveToken(data['token']);
    try {
      user = User.fromJson(data['user']);
    } catch (e) {
      error = 'Error getting user';
    }
    notifyListeners();
  }

  Future register(
    String name,
    String email,
    String password,
    String image,
  ) async {
    var data = await AuthServer.register(name, email, password, image);
    if (data == null) {
      error = 'Email or password is incorrect';
      notifyListeners();
      return;
    }
    LocalStorage.saveToken(data['token']);
    user = User.fromJson(data['user']);
    notifyListeners();
  }

  Future getProfile() async {
    var data = await AuthServer.getProfile();
    if (data == null) {
      error = 'Error getting profile';
      notifyListeners();
      return;
    }
    user = User.fromJson(data['user']);
    notifyListeners();
  }

  void logout() {
    LocalStorage.removeToken();
    user = null;
    notifyListeners();
  }
}
