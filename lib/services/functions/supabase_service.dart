import 'package:resq/services/models/users.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final supabase = Supabase.instance.client;
  static Future<void> saveUserDetails(UserModel user) async {
    try {
      print("Sending Data: ${user.toJson()}");
      await supabase.from("users").insert(user.toJson());
      print('user details saved sucessfully');
    } catch (error) {
      print('error saving user details $error');
    }
  }
}
