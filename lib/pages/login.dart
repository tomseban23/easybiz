import 'package:easybizapp/pages/consts.dart';
import 'package:easybizapp/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //final String baseUrl = 'http://192.168.43.41:3000';
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  Future<http.Response> createPost(String url,
      {Map<String, String>? headers, body}) async {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    return response; // Return the response directly
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
       designSize: Size(375, 812),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                 SizedBox(height: 32.h),
                _buildTextField('Username', Icons.person, username),
                 SizedBox(height: 16.h),
                _buildTextField('Password', Icons.lock, password,
                    obscureText: true),
                 SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      String userName = username.text;
                      String userPassword = password.text;
      
                      final http.Response response = await createPost(
                        // Capture the response
                        '$baseUrl/login',
                        headers: {"Content-Type": "application/json"},
                        body: jsonEncode({
                          "user_name": userName,
                          "user_password": userPassword,
                        }),
                      );
      
                      if (!mounted)
                        return; // Check if the widget is still mounted
      
                     if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login successful!'),
        backgroundColor: Colors.green,
      ),
        );
      
        print(response.body);
      
        // Decode the JSON response
        final user = jsonDecode(response.body);
      
        // Save in Shared Preferences
        final prefs = await SharedPreferences.getInstance();
        
        // Store each individual field if needed
        await prefs.setString('comp_code', user['comp_code']);
        await prefs.setString('user_id', user['user_id']);
        await prefs.setString('user_name', user['user_name']);
        await prefs.setString('user_type', user['user_type']);
        
        // Optionally, store the entire user object as a JSON string
        await prefs.setString('user_data', jsonEncode(user));
      
        // Retrieve and print for verification
        final userData = await prefs.getString('user_data');
        print(["done", userData]);
      
        Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserDataPage()),
        );
      }
       else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Username or password incorrect'), // More accurate message
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } catch (e) {
                      print('Error: $e');
                      if (!mounted) return; // Double check
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                    backgroundColor: Color(0xFFCDFD5D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:
                      const Text('Login', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                ),
                 SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
       // prefixIcon: Icon(icon, color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }
}
