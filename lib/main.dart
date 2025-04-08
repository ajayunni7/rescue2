import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resq/firebase_options.dart';
import 'package:resq/pages/others/admin_home.dart';
import 'package:resq/pages/others/admin_login.dart';
import 'package:resq/pages/others/alert_page.dart';
import 'package:resq/pages/others/bottomnav.dart';
import 'package:resq/pages/others/splash.dart';
import 'package:resq/pages/others/user_info.dart';
import 'package:resq/pages/others/user_register.dart';
import 'package:resq/pages/others/user_signup.dart';
import 'package:resq/pages/tabs/emergency.dart';
import 'package:resq/pages/tabs/first_aid.dart';
import 'package:resq/pages/tabs/home.dart';
import 'package:resq/services/controllers/admin_controller.dart';
import 'package:resq/services/controllers/adminauth_controller.dart';
import 'package:resq/services/controllers/adminhome_controller.dart';
import 'package:resq/services/controllers/auth_controller.dart';
import 'package:resq/services/controllers/user_controller.dart';
import 'package:resq/services/notification_service.dart';
import 'package:resq/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("Background Message: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Foreground Message: ${message.notification?.title}");
    NotificationService().showNotification(message);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("Notification clicked!");
  });
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await NotificationService().initLocalNotifications();
  await Supabase.initialize(
      url: 'https://fibmjftonxyopwwiijav.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZpYm1qZnRvbnh5b3B3d2lpamF2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDEzMzQ3OTgsImV4cCI6MjA1NjkxMDc5OH0.AKNjcEoMb-HBkRFpQV4KqXk9WBiMkGYHUpu6tdf_lhU');
  Get.put(AuthController());
  Get.put(UserDetailsController());
  Get.put(AdminAuthController());
  Get.put(AdminHomeController());
  Get.put(FirstAidController());
  Get.put(AdminController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => AuthChecker(),
        ),
        GetPage(
          name: '/bottomnav',
          page: () => BottomNavPage(),
        ),
        GetPage(
          name: '/onboard',
          page: () => OnboardingPage(),
        ),
        GetPage(
          name: '/signin',
          page: () => UserSignup(),
        ),
        GetPage(
          name: '/signup',
          page: () => UserRegister(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/profile',
          page: () => UserInfo(),
        ),
        GetPage(
          name: '/sos',
          page: () => EmergencyPage(),
        ),
        GetPage(
          name: '/adminLogin',
          page: () => AdminLogin(),
        ),
        GetPage(
          name: '/adminHome',
          page: () => AdminHomePage(),
        ),
        GetPage(
          name: '/alert',
          page: () => AdminAlertPage(),
        ),
      ],
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/fireman.png'),
              Container(
                width: res.screenWidth,
                height: res.height(0.53),
                decoration: const BoxDecoration(
                  color: Color(0xff0C3B2E),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                        height: res.width(0.5),
                        width: res.width(0.5),
                        child: Image.asset('assets/logo.png')),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Column(
                        children: [
                          Text(
                            'Your Crisis Navigator,Providing Support When It Matters Most',
                            style: AppTextStyles.headlineMedium,
                          ),
                          SizedBox(
                            height: res.width(0.08),
                          ),
                          InkWell(
                            onTap: () => Get.toNamed('/signin'),
                            child: Container(
                              height: res.width(0.15),
                              decoration: BoxDecoration(
                                  color: const Color(0xffFFBA00),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Text(
                                  'Get Started',
                                  style: AppTextStyles.headlineMediumBlack,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
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
