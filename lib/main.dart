import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/controllers/gym_controller.dart';
import 'package:motion/motion.dart';
import 'package:sizer/sizer.dart';

import 'controllers/auth_controller.dart';
import 'controllers/general_controller.dart';
import 'views/auth/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Motion.instance.initialize();
  Motion.instance.setUpdateInterval(60.fps);
  runApp(const MainApp());
}

ThemeData _darkTheme = ThemeData.dark().copyWith(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF83BCFF),
  ),
);

ThemeData _lightTheme = ThemeData(
  useMaterial3: false,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,

  primarySwatch: Colors.blue,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF83BCFF),
  ),
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gym Kid',
        initialBinding: InitialBinding(),
        theme: _lightTheme,
        darkTheme: _darkTheme,
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
      );
    });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(GeneralController());
    Get.put(GymController());

    Get.put(AuthController());
    Get.put(MotionController());
  }
}