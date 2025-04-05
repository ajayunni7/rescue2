import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminAuthController extends GetxController {
  final supabase = Supabase.instance.client;
  var isLoading = false.obs;

  // Admin Sign-In Function with Debug Prints
  Future<void> signInAsAdmin(String email, String password) async {
    isLoading.value = true;
    print("Attempting admin sign-in for email: $email"); // Debug print

    try {
      // Step 1: Authenticate using Supabase Auth
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        print("Authentication failed: Invalid credentials");
        Get.snackbar("Error", "Invalid email or password");
        isLoading.value = false;
        return;
      }

      print("Authenticated as: ${user.email}"); // Debug print

      // Step 2: Check if user exists in the admins table
      final adminCheck = await supabase
          .from('admins')
          .select('id, email')
          .eq('email', email)
          .maybeSingle();

      print("Admin Check Response: $adminCheck"); // Debug print

      if (adminCheck == null) {
        print("Access denied: Not an admin");
        Get.snackbar("Access Denied", "You are not an admin");
        await supabase.auth.signOut(); // Sign out non-admin users
        isLoading.value = false;
        return;
      }

      print("Admin verified: Access granted"); // Debug print

      // Step 3: Redirect to Admin Dashboard
      Get.offAllNamed('/adminHome');
      Get.snackbar("Success", "Welcome, Admin!");
    } catch (e) {
      print("Error occurred: $e"); // Debug print
      Get.snackbar("Error", "Login failed: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  // Admin Sign-Out Function
  Future<void> signOut() async {
    await supabase.auth.signOut();
    Get.offAllNamed('/signin'); // Redirect to admin login
  }
}
