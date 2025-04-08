import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminController extends GetxController {
  final supabase = Supabase.instance.client;

  Future<void> sendAlert(String title, String message) async {
    try {
      // Fetch all FCM tokens from Supabase
      final response = await supabase.from('user_details').select('fcm_token');

      final tokens = (response as List)
          .map((row) => row['fcm_token'])
          .where((token) => token != null && token.toString().isNotEmpty)
          .toList();

      if (tokens.isEmpty) {
        Get.snackbar('Error', 'No users with valid FCM tokens');
        return;
      }

      // Send notification to each token
      for (var token in tokens) {
        await _sendNotification(token, title, message);
      }

      Get.snackbar('Success', 'Notification sent to all users');
    } catch (e) {
      print('Error sending alert: $e');
      Get.snackbar('Error', 'Failed to send alert: $e');
    }
  }

  Future<void> _sendNotification(
      String token, String title, String body) async {
    const serverKey = 'YOUR_FCM_SERVER_KEY'; // Replace with your key

    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode({
        'to': token,
        'notification': {
          'title': title,
          'body': body,
        },
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        },
      }),
    );

    print('FCM response: ${response.statusCode} ${response.body}');
  }
}
