import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:resq/pages/others/user_info.dart';
import 'package:resq/pages/tabs/emergency.dart';
import 'package:resq/pages/tabs/first_aid.dart';
import 'package:resq/pages/tabs/home.dart';
import 'package:resq/services/controllers/nav_controller.dart';

class BottomNavPage extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());

  final List<Widget> pages = [
    HomePage(),
    EmergencyPage(),
    FirstAidPage(),
    UserInfo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          pages[navController.selectedIndex.value]), // Update page dynamically
      bottomNavigationBar: Obx(() => Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: GNav(
              gap: 8,
              backgroundColor: Color(0xff0C3B2E),
              activeColor: Color(0xffFFBA00),
              color: Colors.grey,
              padding: const EdgeInsets.all(16),
              selectedIndex: navController.selectedIndex.value,
              onTabChange: (index) {
                navController.changeTabIndex(index); // Change tab
              },
              tabs: const [
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.sos_outlined, text: 'Emergency'),
                GButton(icon: Icons.local_hospital_outlined, text: 'First Aid'),
                GButton(icon: Icons.person_2, text: 'Profile'),
              ],
            ),
          )),
    );
  }
}
