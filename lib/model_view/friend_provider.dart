import 'package:flutter/material.dart';
import 'package:remindly/model/search_user.dart';
import 'package:remindly/services/friend_service.dart';

class FriendProvider extends ChangeNotifier {
  List<Searchuser> users = [];
  List<Searchuser> friends = [];

  String error = '';

  Future searchUser(String name) async {
    // Call the server to get the tasks
    users.clear();
    notifyListeners();
    var data = await FriendServer.searchUser(name);
    if (data != null) {
      users =
          data['users'].map<Searchuser>((e) => Searchuser.fromJson(e)).toList();
    } else {
      error = 'No user found';
      return [];
    }
    notifyListeners();
    return users;
  }

  Future addFriend(String id) async {
    var data = await FriendServer.addFriend(id);
    if (data == null) {
      error = 'Error adding friend';
      notifyListeners();
      return;
    }
    notifyListeners();
  }

  Future getFriends() async {
    var data = await FriendServer.getFriends();
    if (data == null) {
      error = 'Error getting friends';
      notifyListeners();
      return;
    }
    friends =
        data['friends'].map<Searchuser>((e) => Searchuser.fromJson(e)).toList();

    return friends;
  }

  Future getfriends() async {
    friends = await getFriends();
    notifyListeners();
  }
}
