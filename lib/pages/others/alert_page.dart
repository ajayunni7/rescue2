import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/controllers/admin_controller.dart'; // adjust path as needed

class AdminAlertPage extends StatelessWidget {
  final AdminController controller = Get.put(AdminController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send Alert')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: messageController,
              maxLines: 4,
              decoration: InputDecoration(labelText: 'Message'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.sendAlert(
                  titleController.text,
                  messageController.text,
                );
              },
              child: Text('Send Alert'),
            )
          ],
        ),
      ),
    );
  }
}
