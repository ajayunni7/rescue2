import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminHomeController extends GetxController {
  final supabase = Supabase.instance.client;
  var userList = [].obs; // Stores user details
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  Future<void> fetchUserDetails() async {
    isLoading.value = true;

    try {
      final response = await supabase.from('user_details').select('*');

      if (response.isNotEmpty) {
        userList.value = response;
      } else {
        Get.snackbar("No Data", "No users found");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load data: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}

Future<void> sendContactInfo(
    String contactName, String phone, String userId) async {
  try {
    await Supabase.instance.client.from('user_details').update({
      'admin_contact_name': contactName,
      'admin_contact_phone': phone,
    }).eq('user_id', userId);

    Get.snackbar('Success', 'Contact info saved');
  } catch (e) {
    print('Error saving contact info: $e');
    Get.snackbar('Error', 'Failed to save contact info');
  }
}
