import 'package:easybizapp/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easybizapp/pages/login.dart'; // Import your login screen
import 'package:easybizapp/pages/userdetail.dart'; // Import your UserDataPage
//import 'package:easybizapp/pages/dashboard.dart'; // Remove unused import


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure plugins are initialized

  // Check for existing comp_code
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? compCode = prefs.getString('comp_code');

  Widget initialRoute = (compCode != null && compCode.isNotEmpty)
      ? UserDataPage()
      : SignUpScreen(); // Use your Login screen's class name

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final Widget initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sign Up',
            theme: ThemeData(
              fontFamily: 'Poppins',
              primarySwatch: Colors.blue,
            ),
            home: initialRoute));
  }
}
