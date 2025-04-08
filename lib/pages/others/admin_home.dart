import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resq/services/controllers/adminauth_controller.dart';
import 'package:resq/services/controllers/adminhome_controller.dart';
import 'package:resq/services/controllers/adminhome_controller.dart'
    as controller;
import 'package:resq/utils/utils.dart';

class AdminHomePage extends StatelessWidget {
  final AdminHomeController controller = Get.put(AdminHomeController());
  final AdminAuthController authcontroller = Get.put(AdminAuthController());

  AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0C3B2E),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authcontroller.signOut();
        },
        child: Icon(Icons.logout_outlined),
      ),
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        leading: IconButton(
            onPressed: () {
              Get.toNamed('/alert');
            },
            icon: Icon(Icons.dangerous_rounded)),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.userList.isEmpty) {
          return Center(child: Text("No user data found."));
        }

        return ListView.builder(
          itemCount: controller.userList.length,
          itemBuilder: (context, index) {
            final user = controller.userList[index];
            return InkWell(
              onTap: () => _showContactDialog(context, user['user_id']),
              child: Card(
                child: ListTile(
                  title: Text(user['name'] ?? "No Name"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Location: ${user['location'] ?? 'Unknown'}"),
                      Text("Note: ${user['note'] ?? 'No Note'}"),
                    ],
                  ),
                  trailing: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getStatusColor(user['status']),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      user['status'] ?? 'Unknown',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Safe':
        return Colors.green;
      case 'Mild':
        return Colors.orange;
      case 'Severe':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

void _showContactDialog(BuildContext context, String userId) {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(
        "Send volunteer Info",
        style: AppTextStyles.bodyLargeBlack,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(labelText: "Phone Number"),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final name = nameController.text.trim();
            final phone = phoneController.text.trim();
            if (name.isNotEmpty && phone.isNotEmpty) {
              controller.sendContactInfo(name, phone, userId);
              Navigator.pop(context);
            } else {
              Get.snackbar('Error', 'Please fill all fields');
            }
          },
          child: Text("Send"),
        ),
      ],
    ),
  );
}
