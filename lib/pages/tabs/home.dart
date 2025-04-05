import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resq/services/controllers/auth_controller.dart';
import 'package:resq/services/controllers/user_controller.dart';
import 'package:resq/utils/utils.dart';
import 'package:resq/widgets/textfeild.dart';

class HomePage extends StatelessWidget {
  final UserDetailsController controller = Get.find<UserDetailsController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final AuthController authController = Get.find();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    final user = authController.supabase.auth.currentUser;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Welcome, ${user?.email ?? 'User'}!",
                style: TextStyle(fontSize: 20),
              ),
              Text('No emergency alerts'),
              Text("Let's get you prepared just in case"),
              SizedBox(
                height: res.width(0.05),
              ),
              Container(
                height: res.width(0.35),
                width: res.width(0.9),
                decoration: BoxDecoration(
                    color: Color(0xff0C3B2E),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '10% chance of',
                        style: AppTextStyles.bodyLargeWhite,
                      ),
                      Text(
                        'ThunderStorm',
                        style: AppTextStyles.bodyLargeWhite,
                      ),
                      SizedBox(
                        height: res.width(0.05),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: res.width(0.4),
                          ),
                          const Icon(
                            Icons.location_city_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(
                            width: res.width(0.02),
                          ),
                          Text(
                            'Haripad, Kerala',
                            style: AppTextStyles.bodyLargeWhite,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '    Are you facing an Emergency?',
                          style: AppTextStyles.bodyLargeBlack,
                        ),
                        SizedBox(
                          width: res.width(0.05),
                        ),
                        const Icon(Icons.arrow_forward)
                      ],
                    ),
                    TextField(
                      controller: noteController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Colors.white70),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: res.width(0.04),
                    ),
                    CustomTextField(
                      hintText: 'Name',
                      controller: nameController,
                    ),
                    SizedBox(
                      height: res.width(0.04),
                    ),
                    CustomTextField(
                      hintText: 'Location',
                      controller: locationController,
                    ),
                    SizedBox(
                      height: res.width(0.04),
                    ),
                    InkWell(
                      onTap: () {
                        controller.name.value = nameController.text;
                        controller.location.value = locationController.text;
                        controller.note.value = noteController.text;
                      },
                      child: Container(
                        height: res.width(0.1),
                        decoration: BoxDecoration(
                            color: const Color(0xffFFBA00),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            'Ask for help!',
                            style: AppTextStyles.headlineMediumBlack,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
