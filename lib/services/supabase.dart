import 'package:supabase_flutter/supabase_flutter.dart';

class SupaService {
  //auth
  static Future<void> signInWithGoogle() async {
    final response = await Supabase.instance.client.auth
        .signInWithOAuth(OAuthProvider.google);
    if (response == true) {
      print('User signed in successfully!');
    } else {
      print('Error signing in');
    }
  }

  static bool isUserAuthenticated() {
  final user = Supabase.instance.client.auth.currentUser;
  return user != null;
}

  static Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
  }

//User Management
  static User? getCurrentUser() {
    return Supabase.instance.client.auth.currentUser;
  }

//Task Management
 static  Future<void> insertTask(String title, String description, DateTime startDate,
      DateTime reminderTime) async {
    final response = await Supabase.instance.client.from('tasks').insert({
      'user_id':
          Supabase.instance.client.auth.currentUser!.id, // Current user's ID
      'title': title,
      'description': description,
      'start_date': startDate.toIso8601String(),
      'reminder_time': reminderTime.toIso8601String(),
      'status': 'pending',
    }).select();
  }

//Get all tasks
  static Future<List<Map<String, dynamic>>> getTasks() async {
    final response = await Supabase.instance.client
        .from('tasks')
        .select()
        .eq('user_id', Supabase.instance.client.auth.currentUser!.id)
        .select();
    return response;
  }

  ///Update task

  static Future<void> updateTaskStatus(String taskId, String status) async {
    final response = await Supabase.instance.client
        .from('tasks')
        .update({'status': status})
        .eq('id', taskId)
        .select();
  }

// Friends Management Functions

  static Future<void> sendFriendRequest(String friendId) async {
    final response = await Supabase.instance.client.from('friends').insert({
      'user_id': Supabase.instance.client.auth.currentUser!.id,
      'friend_id': friendId,
      'status': 'pending',
    }).select();
  }

//get
  static Future<List<Map<String, dynamic>>> getFriends() async {
    final response = await Supabase.instance.client
        .from('friends')
        .select()
        .eq('user_id', Supabase.instance.client.auth.currentUser!.id)
        .eq('status', 'accepted')
        .select();

    return response;
  }

//Shared Tasks Functions

 static  Future<void> shareTask(String taskId, String friendId) async {
    final response =
        await Supabase.instance.client.from('shared_tasks').insert({
      'task_id': taskId,
      'shared_with': friendId,
      'shared_by': Supabase.instance.client.auth.currentUser!.id,
      'status': 'pending',
    }).select();
  }

 static  Future<List<Map<String, dynamic>>> getSharedTasks() async {
    final response = await Supabase.instance.client
        .from('shared_tasks')
        .select('tasks(*), shared_by')
        .eq('shared_with', Supabase.instance.client.auth.currentUser!.id)
        .select();

    return response;
  }
}
