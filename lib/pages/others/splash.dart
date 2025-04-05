import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthChecker extends StatelessWidget {
  final supabase = Supabase.instance.client;

  AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    print("🔍 AuthChecker: Building Widget...");

    return FutureBuilder(
      future: _checkAuthStatus(),
      builder: (context, snapshot) {
        print("📡 FutureBuilder State: ${snapshot.connectionState}");

        if (snapshot.connectionState == ConnectionState.waiting) {
          print("⏳ Checking Auth Status...");
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          print("✅ Auth Status Received: ${snapshot.data}");

          // Navigate based on auth status
          Future.microtask(
            () {
              if (snapshot.data == true) {
                print("🚀 User is logged in. Redirecting to /bottomnav...");
                Get.offAllNamed('/bottomnav');
              } else {
                print(
                    "🔄 User is not logged in. Redirecting to /onboarding...");
                Get.offAllNamed('/signin');
              }
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Future<bool> _checkAuthStatus() async {
    final session = supabase.auth.currentSession;
    print("🔑 Current Session: $session");
    return session != null; // Return true if logged in
  }
}
