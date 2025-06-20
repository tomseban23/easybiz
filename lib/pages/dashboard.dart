import 'dart:convert';
import 'package:easybizapp/pages/consts.dart';
import 'package:easybizapp/pages/userdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserDataPage extends StatefulWidget {
  @override
  _UserDataPageState createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  List<dynamic> _users = [];
  List<String> _areas = [];
  String? _selectedArea = "All"; // Default selection to show all
  String _searchName = '';
  bool _isLoading = true;
  String? _compCode; // Store comp_code here

  @override
  void initState() {
    super.initState();
    _loadCompCodeAndFetchData(); // Call a combined function
  }

  Future<void> _loadCompCodeAndFetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _compCode = prefs.getString('comp_code');

    if (_compCode == null || _compCode!.isEmpty) {
      // Handle the case where comp_code is not found.
      // This should ideally not happen, but add a safety net.
      print("Error: comp_code not found in SharedPreferences");
      // Optionally navigate back to the login screen or show an error message.
      return;
    }

    _fetchData();
  }


  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/allcust?comp_code=$_compCode')); // Replace with your actual endpoint and pass comp_code
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          _users = jsonData['users'];
          _areas = ["All", ...List<String>.from(jsonData['areas'])]; // Add "All" to areas
          _isLoading = false;
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

 Widget _buildCustTypeBox(String custType) {
    Color boxColor;
    String label;

    if (custType == 'W') {
      boxColor = Color(0xFFE579B9);
      label = 'W';
    } else if (custType == 'R') {
      boxColor = Color(0xFFCDFD5D);
      label = 'R';
    } else {
      return SizedBox.shrink(); // Return an empty widget if cust_type is neither W nor R
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 3),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenUtilInit(
         designSize: Size(375, 812),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    SizedBox(height: 50.h,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonFormField<String>(
                        value: _selectedArea == "All" ? null : _selectedArea, // Ensures hint shows when "All" is selected
                        items: _areas.map((area) {
                          return DropdownMenuItem<String>(
                            value: area,
                            child: Text(area),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedArea = value ?? "All"; // Defaults to "All" if null
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Location', // Will now be visible when no selection is made
                          hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          prefixIcon: Icon(Icons.location_on, color: Color(0xFF8C8DF7)),
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchName = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          prefixIcon: Icon(Icons.search, color: Color(0xFF8C8DF7)),
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _users.length,
                        itemBuilder: (context, index) {
                          final user = _users[index];
                          bool matchesName = user['cust_name'].toLowerCase().contains(_searchName.toLowerCase());
                                bool matchesArea = (_selectedArea == "All" || user['cust_address'].contains(_selectedArea!));
        
                          if (matchesArea && matchesName) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  ListTile(
          title: Text(user['cust_name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        SizedBox(height: 5.h),
        Text('${user['cust_address']}', style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 5.h),
        Text('${user['cust_phone']}', style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          onTap: () async {
            // Retrieve the stored comp_code
            final prefs = await SharedPreferences.getInstance();
            final compCode = prefs.getString('comp_code') ?? '';
        
            // Navigate to UserDetailsPage and pass data
            Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDetailsPage(
            userData: user,
            compCode: compCode,
            custType: user['cust_type'],
          ),
        ),
            );
          },
        ),
                                  Positioned(
                                    right:
                                        10,
                                    top:
                                        10,
                                    child:
                                        _buildCustTypeBox(user['cust_type']),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
