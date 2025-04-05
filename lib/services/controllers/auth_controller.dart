import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final supabase = Supabase.instance.client;
  var isLoading = false.obs;

  // Sign In Function
  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      final AuthResponse response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      isLoading.value = false;

      if (response.user != null) {
        print("User signed in: ${response.user!.id}");

        // Save FCM Token after login
        await saveFCMToken(response.user!.id);

        Get.offAllNamed('/bottomnav');
      } else {
        Get.snackbar('Sign In Failed', 'Invalid email or password');
      }
    } catch (e) {
      isLoading.value = false;
      print("Sign in error: $e");
      Get.snackbar('Error', e.toString());
    }
  }

  // Sign Up Function
  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      isLoading.value = false;

      if (response.user != null) {
        print("User signed up: ${response.user!.id}");

        // Save FCM Token after signup
        await saveFCMToken(response.user!.id);

        Get.offAllNamed('/bottomnav');
      }
    } catch (e) {
      isLoading.value = false;
      print("Sign up error: $e");
      Get.snackbar('Error', e.toString());
    }
  }

  // Function to save FCM Token
  Future<void> saveFCMToken(String userId) async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        print("FCM Token generated: $fcmToken");

        final existing =
            await supabase.from('user_details').select().eq('id', userId);

        if (existing.isEmpty) {
          // No row exists, insert new
          await supabase.from('user_details').insert({
            'id': userId,
            'fcm_token': fcmToken,
            // You can add default fields like 'name': '', 'status': 'Safe', etc.
          });
          print("✅ New user_details row created with FCM token.");
        } else {
          // Update existing row
          final updated = await supabase
              .from('user_details')
              .update({'fcm_token': fcmToken})
              .eq('id', userId)
              .select();

          if (updated.isNotEmpty) {
            print("✅ FCM Token saved successfully for user: $userId");
          } else {
            print("⚠️ Failed to update FCM token for existing user.");
          }
        }
      } else {
        print("❌ FCM Token is null");
      }
    } catch (e) {
      print("Failed to save FCM token: $e");
      Get.snackbar('Error', 'Failed to save FCM token: $e');
    }
  }

  // Sign Out Function
  Future<void> signOut() async {
    await supabase.auth.signOut();
    print("User signed out");
  }
}
