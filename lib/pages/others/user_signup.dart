import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resq/pages/others/user_register.dart';
import 'package:resq/services/controllers/auth_controller.dart';
import 'package:resq/utils/utils.dart';
import 'package:resq/widgets/textfeild.dart';

class UserSignup extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find();
  UserSignup({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/adminLogin');
        },
        backgroundColor: const Color(0xff0C3B2E),
        child: const Icon(
          Icons.admin_panel_settings,
          color: Color(0xffFFBA00),
        ),
      ),
      backgroundColor: Color(0xff0C3B2E),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: res.width(0.45),
            child: Image.asset('assets/logo.png'),
          ),
          Expanded(
            child: Container(
              color: const Color(0xffF9FBFA),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get Started with                     ResQ',
                      style: AppTextStyles.headlineLargeBlack,
                    ),
                    SizedBox(
                      height: res.width(0.05),
                    ),
                    Text(
                      'Email',
                      style: AppTextStyles.bodyLargeBlack,
                    ),
                    CustomTextField(
                      hintText: 'email',
                      controller: emailController,
                    ),
                    SizedBox(
                      height: res.width(0.05),
                    ),
                    Text(
                      'Password',
                      style: AppTextStyles.bodyLargeBlack,
                    ),
                    CustomTextField(
                      hintText: 'password',
                      controller: passwordController,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: res.width(0.05),
                    ),
                    Obx(() {
                      return authController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : Padding(
                              padding:
                                  const EdgeInsets.only(left: 110, right: 110),
                              child: ElevatedButton(
                                onPressed: () {
                                  authController.signIn(
                                    emailController.text,
                                    passwordController.text,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffFFBA00),
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.only(
                                        left: 50, right: 50),
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: const Text("Log In"),
                              ),
                            );
                    }),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 100, right: 100),
                    //   child: Container(
                    //     width: res.width(0.4),
                    //     height: res.width(0.12),
                    //     decoration: BoxDecoration(
                    //         color: const Color(0xffFFBA00),
                    //         borderRadius: BorderRadius.circular(12)),
                    //     child: Center(
                    //       child: Text(
                    //         'Log In',
                    //         style: AppTextStyles.bodyLargeBlack,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: res.width(0.05),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: res.width(0.18),
                        ),
                        const Text(
                          "Don't have an account?",
                        ),
                        SizedBox(
                          width: res.width(0.03),
                        ),
                        InkWell(
                          onTap: () => Get.to(() => UserRegister()),
                          child: Text(
                            'SignUp',
                            style: AppTextStyles.bodyLargeBlack,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
