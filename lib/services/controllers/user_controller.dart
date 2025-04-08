import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDetailsController extends GetxController {
  final supabase = Supabase.instance.client;

  var name = ''.obs;
  var location = ''.obs;
  var note = ''.obs;
  var status = 'Safe'.obs;
  var adminContactName = ''.obs;
  var adminContactPhone = ''.obs; // Default status is "Safe"

  // Function to change status when button is clicked
  void changeStatus() {
    if (status.value == 'Safe') {
      status.value = 'Mild';
    } else if (status.value == 'Mild') {
      status.value = 'Severe';
    } else {
      status.value = 'Safe';
    }
    print('Status changed to: ${status.value}');
  }

  // Function to save user details in Supabase
  Future<void> saveUserDetails() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    try {
      final response = await supabase.from('user_details').upsert([
        {
          'user_id': user.id,
          'name': name.value,
          'location': location.value,
          'note': note.value,
          'status': status.value,
          'created_at': DateTime.now().toIso8601String(),
        }
      ]);

      print('Response: $response'); // ✅ Print response to check its format

      // ✅ Just assume success if no exception is thrown
      Get.snackbar('Success', 'Details saved successfully');
      Get.offAllNamed('/bottomnav'); // Navigate to home after saving
    } catch (e) {
      print('Exception occurred: $e'); // ✅ Print actual error message
      Get.snackbar('Error', 'Failed to save data: $e');
    }
  }

  Future<void> fetchUserDetails() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final data = await supabase
        .from('user_details')
        .select()
        .eq('user_id', user.id)
        .maybeSingle();

    if (data != null) {
      name.value = data['name'] ?? '';
      location.value = data['location'] ?? '';
      note.value = data['note'] ?? '';
      status.value = data['status'] ?? 'Safe';

      adminContactName.value = data['admin_contact_name'] ?? '';
      adminContactPhone.value = data['admin_contact_phone'] ?? '';

      // 👉 Show dialog only if both values exist
      if (adminContactName.value.isNotEmpty &&
          adminContactPhone.value.isNotEmpty) {
        Future.delayed(Duration.zero, () {
          Get.dialog(
            AlertDialog(
              title: Text("Volunteer Contact Details"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Name: ${adminContactName.value}"),
                  SizedBox(height: 8),
                  Text("Phone: ${adminContactPhone.value}"),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text("OK"),
                ),
              ],
            ),
          );
        });
      }
    }
  }
}
