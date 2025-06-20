// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// class App extends StatefulWidget {
//   @override
//   _AppState createState() => _AppState();
// }
// class _AppState extends State<App> {
//   String quantity = '';
//   String remarks = '';
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(375, 812),
//       child: Scaffold(
//         backgroundColor: Colors.pink[50],
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Container(
//               width: MediaQuery.of(context).size.width > 600 ? 600 : double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(24.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'YD Body Lotion 100ML (Rose)',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                   SizedBox(height: 16.h),
//                   Row(
//                     children: [
//                       _buildInfoBox(context, 'Stock', '23'),
//                       SizedBox(width: 8.w),
//                       _buildInfoBox(context, 'MRP', '120.00'),
//                       SizedBox(width: 8.w),
//                       _buildInfoBox(context, 'Tax', '18.00 R%'),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   Row(
//                     children: [
//                       _buildInfoBox(context, 'Rate', '95.95'),
//                       SizedBox(width: 8.w),
//                       _buildInfoBox(context, 'Net Rate', '95.946'),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Qty',
//                               style: TextStyle(
//                                 color: Colors.purple[400],
//                                 fontSize: 12,
//                               ),
//                             ),
//                             TextField(
//                               keyboardType: TextInputType.number,
//                               onChanged: (value) {
//                                 setState(() {
//                                   quantity = value;
//                                 });
//                               },
//                               decoration: InputDecoration(
//                                 filled: true,
//                                 fillColor: Colors.purple[50],
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 contentPadding: EdgeInsets.all(12),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: 8.w),
//                       _buildInfoBox(context, 'Free', ''),
//                       SizedBox(width: 8.w),
//                       _buildInfoBox(context, 'Discount', ''),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   Row(
//                     children: [
//                       _buildInfoBox(context, 'Offer', 'NA'),
//                       SizedBox(width: 8.w),
//                       Expanded(
//                         flex: 2,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Remarks',
//                               style: TextStyle(
//                                 color: Colors.purple[400],
//                                 fontSize: 12,
//                               ),
//                             ),
//                             TextField(
//                               onChanged: (value) {
//                                 setState(() {
//                                   remarks = value;
//                                 });
//                               },
//                               decoration: InputDecoration(
//                                 filled: true,
//                                 fillColor: Colors.purple[50],
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 contentPadding: EdgeInsets.all(12),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16.h),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.black,
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30.0),
//                             ),
//                             padding: EdgeInsets.symmetric(vertical: 16),
//                           ),
//                           child: Text('Cancel'),
//                         ),
//                       ),
//                       SizedBox(width: 8.w),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.lime[300],
//                             foregroundColor: Colors.black,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30.0),
//                             ),
//                             padding: EdgeInsets.symmetric(vertical: 16),
//                           ),
//                           child: Text('Add'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _buildInfoBox(BuildContext context, String label, String value) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               color: Colors.purple[400],
//               fontSize: 12,
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.purple[50],
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Text(
//               value,
//               style: TextStyle(color: Colors.grey[800]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// new code userdetail page


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:http/http.dart' as http;
// import 'package:easybizapp/pages/consts.dart'; // Ensure this file exists and defines baseUrl
// class UserDetailsPage extends StatefulWidget {
//   final Map<String, dynamic> userData;
//   final String compCode;
//   const UserDetailsPage({Key? key, required this.userData, required this.compCode}) : super(key: key);
//   @override
//   _UserDetailsPageState createState() => _UserDetailsPageState();
// }
// class _UserDetailsPageState extends State<UserDetailsPage> {
//   TextEditingController _searchController = TextEditingController();
//   List<Map<String, dynamic>> _userDetails = [];
//   List<Map<String, dynamic>> _filteredDetails = [];
//   bool _isLoading = true;
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserDetails();
//   }
//   Future<void> _fetchUserDetails() async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/shopdetails'),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"comp_code": widget.compCode}),
//       );
//       //print("Response Body: ${response.body}"); // Debugging
//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         if (jsonData is List) {
//           setState(() {
//             _userDetails = List<Map<String, dynamic>>.from(jsonData);
//             _filteredDetails = List.from(_userDetails);
//             _isLoading = false;
//           });
//         } else if (jsonData is Map<String, dynamic> && jsonData.containsKey('details')) {
//           setState(() {
//             _userDetails = List<Map<String, dynamic>>.from(jsonData['details']);
//             _filteredDetails = List.from(_userDetails);
//             _isLoading = false;
//           });
//         } else {
//           _showError("Unexpected data format");
//         }
//       } else {
//         _showError("Failed to fetch details. Status: ${response.statusCode}");
//       }
//     } catch (e) {
//       _showError("Error fetching data: $e");
//     }
//   }
//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), backgroundColor: Colors.red),
//     );
//     setState(() {
//       _isLoading = false;
//     });
//   }
//   void _filterSearchResults(String query) {
//     if (query.isEmpty) {
//       setState(() => _filteredDetails = List.from(_userDetails));
//       return;
//     }
//     setState(() {
//       _filteredDetails = _userDetails.where((item) {
//         final name = (item['item_name'] ?? '').toString().toLowerCase();
//         return name.contains(query.toLowerCase());
//       }).toList();
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(375, 812),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           children: [
//             SizedBox(height: 100.h),
//             _buildCustomerInfo(),
//             _buildSearchBar(),
//             SizedBox(height: 10.h),
//             Expanded(child: _isLoading ? _buildLoadingIndicator() : _buildItemList()),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildSearchBar() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: TextField(
//         controller: _searchController,
//         onChanged: _filterSearchResults,
//         decoration: InputDecoration(
//           hintText: 'Search Item',
//           suffixIcon: _searchController.text.isNotEmpty
//               ? IconButton(
//                   icon: Icon(Icons.clear, color: Colors.grey),
//                   onPressed: () {
//                     _searchController.clear();
//                     _filterSearchResults('');
//                   },
//                 )
//               : null,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
//           filled: true,
//           fillColor: Colors.grey[200],
//           contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//         ),
//       ),
//     );
//   }
//   Widget _buildLoadingIndicator() {
//     return Center(child: CircularProgressIndicator());
//   }
//   Widget _buildItemList() {
//     return _filteredDetails.isNotEmpty
//         ? ListView.builder(
//             padding: EdgeInsets.all(16),
//             itemCount: _filteredDetails.length,
//             itemBuilder: (context, index) {
//               final item = _filteredDetails[index];
//               return Container(
//                 margin: EdgeInsets.only(bottom: 12),
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 2, blurRadius: 5, offset: Offset(0, 3)),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(item['item_name'] ?? 'No Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         SizedBox(height: 6.h),
//                         Text("Stock: ${item['item_qty'] ?? 'N/A'}  |  Price: ${item['item_price1'] ?? 'N/A'}",
//                             style: TextStyle(fontSize: 14)),
//                       ],
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.edit, color: Colors.blue),
//                       onPressed: () => showItemDialog(
//                         context,
//                         item,
//                         TextEditingController(),
//                         TextEditingController(),
//                         TextEditingController(),
//                         TextEditingController(),
//                         TextEditingController(),
//                         TextEditingController(),
//                         TextEditingController(),
//                         TextEditingController(),
//                         TextEditingController(),
//                         _updateItem,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           )
//         : Center(child: Text("No Data Found", style: TextStyle(fontSize: 16, color: Colors.grey)));
//   }
//   Widget _buildCustomerInfo() {
//     return Container(
//        double.infinity,
//       margin: EdgeInsets.all(16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(color: const Color(0xFF8C8DF7), borderRadius: BorderRadius.circular(15)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(widget.userData['cust_name'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
//           SizedBox(height: 8.h),
//           Text("Address: ${widget.userData['cust_address']}", style: TextStyle(fontSize: 16, color: Colors.black)),
//           SizedBox(height: 8.h),
//           Text("Phone: ${widget.userData['cust_phone']}", style: TextStyle(fontSize: 16, color: Colors.black)),
//         ],
//       ),
//     );
//   }
//   void showItemDialog(BuildContext context, Map<String, dynamic> item,
//       TextEditingController stockController,
//       TextEditingController rateController,
//       TextEditingController qtyController,
//       TextEditingController offerController,
//       TextEditingController freeController,
//       TextEditingController remarksController,
//       TextEditingController discountController,
//       TextEditingController mrpController,
//       TextEditingController taxController,
//       Function(Map<String, dynamic>, Map<String, dynamic>) _updateItem) {
//     // Initialize controllers with existing values, handling nulls
//     stockController.text = item['item_qty']?.toString() ?? '';
//     rateController.text = item['item_price1']?.toString() ?? '';
//     qtyController.text = item['qty']?.toString() ?? '';
//     offerController.text = item['offer'] ?? '';
//     freeController.text = item['free']?.toString() ?? '';
//     remarksController.text = item['remarks'] ?? '';
//     discountController.text = item['discount']?.toString() ?? '';
//     mrpController.text = item['item_mrp']?.toString() ?? '';
//     taxController.text = item['tax']?.toString() ?? '';
//     // Calculate initial net rate
//     final netRate = calculateNetRate(
//       double.tryParse(rateController.text) ?? 0.0,
//       double.tryParse(discountController.text) ?? 0.0,
//     );
//     final netRateController = TextEditingController(text: netRate.toStringAsFixed(2)); // Display with 2 decimal places
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('${item['item_name'] ?? "Edit Item"}'),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(child: _buildInputField('Stock', stockController)),
//                     Expanded(child: _buildInputField('MRP', mrpController)),
//                     Expanded(child: _buildInputField('Tax', taxController)),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(child: _buildInputField('Rate', rateController)),
//                     Expanded(
//                       child: _buildInputField(
//                         'Net Rate',
//                         netRateController,
//                         enabled: false, // Make it non-editable
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(child: _buildInputField('Qty', qtyController)),
//                     Expanded(child: _buildInputField('Free', freeController)),
//                     Expanded(child: _buildInputField('Discount', discountController)),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(child: _buildInputField('Offer Remark', offerController)),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop(); // Close the dialog
//                       },
//                       child: Text('Cancel'),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         // 1. Collect the updated values
//                         final updatedItem = {
//                           'item_qty': int.tryParse(stockController.text) ?? 0,
//                           'item_price1': double.tryParse(rateController.text) ?? 0.0,
//                           'qty': int.tryParse(qtyController.text) ?? 0,
//                           'offer': offerController.text,
//                           'free': int.tryParse(freeController.text) ?? 0,
//                           'remarks': remarksController.text,
//                           'discount': double.tryParse(discountController.text) ?? 0.0,
//                           'item_mrp': double.tryParse(mrpController.text) ?? 0.0,
//                           'tax': double.tryParse(taxController.text) ?? 0.0,
//                         };
//                         // 2.  Handle Add logic here -  **Crucial:  Send updates to backend**
//                         _updateItem(item, updatedItem);
//                         Navigator.of(context).pop(); // Close the dialog
//                       },
//                       child: Text('Add'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//   Widget _buildInputField(String label, TextEditingController controller, {bool enabled = true}) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         controller: controller,
//         enabled: enabled, // Control the editability
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//         ),
//       ),
//     );
//   }
//   // **Important:**  Implement this function to actually update the data
//   Future<void> _updateItem(Map<String, dynamic> oldItem, Map<String, dynamic> newItem) async {
//     // 1.  Prepare your request body
//     final requestBody = {
//       'comp_code': widget.compCode,
//       'item_id': oldItem['item_id'], // Assuming you have an item_id to identify the item to update
//       'updated_data': newItem, // Send all the updated fields
//     };
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/orders'), // Replace with your actual endpoint
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(requestBody),
//       );
//       if (response.statusCode == 200) {
//         // Success!
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Item updated successfully!'), backgroundColor: Colors.green),
//         );
//         // Optionally, you can refresh the item list after a successful update
//         _fetchUserDetails(); // Reload data from the server
//       } else {
//         // API error
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to update item.  Status: ${response.statusCode}'), backgroundColor: Colors.red),
//         );
//       }
//     } catch (e) {
//       // Network error or other exception
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error updating item: $e'), backgroundColor: Colors.red),
//       );
//     }
//   }
//   // Function to calculate net rate after discount
//   double calculateNetRate(double rate, double discount) {
//     return rate - (rate * (discount / 100));
//   }
// }





// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:http/http.dart' as http;
// import 'package:easybizapp/pages/consts.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Ensure this file exists and defines baseUrl
// class UserDetailsPage extends StatefulWidget {
//   final Map<String, dynamic> userData;
//   final String compCode;
//   const UserDetailsPage({Key? key, required this.userData, required this.compCode}) : super(key: key);
//   @override
//   _UserDetailsPageState createState() => _UserDetailsPageState();
// }
// class _UserDetailsPageState extends State<UserDetailsPage> {
//   TextEditingController _searchController = TextEditingController();
//   List<Map<String, dynamic>> _userDetails = [];
//   List<Map<String, dynamic>> _filteredDetails = [];
//   bool _isLoading = true;
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserDetails();
//   }
//   Future<void> _fetchUserDetails() async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/shopdetails'),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"comp_code": widget.compCode}),
//       );
//       //print("Response Body: ${response.body}"); // Debugging
//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         if (jsonData is List) {
//           setState(() {
//             _userDetails = List<Map<String, dynamic>>.from(jsonData);
//             _filteredDetails = List.from(_userDetails);
//             _isLoading = false;
//           });
//         } else if (jsonData is Map<String, dynamic> && jsonData.containsKey('details')) {
//           setState(() {
//             _userDetails = List<Map<String, dynamic>>.from(jsonData['details']);
//             _filteredDetails = List.from(_userDetails);
//             _isLoading = false;
//           });
//         } else {
//           _showError("Unexpected data format");
//         }
//       } else {
//         _showError("Failed to fetch details. Status: ${response.statusCode}");
//       }
//     } catch (e) {
//       _showError("Error fetching data: $e");
//     }
//   }
//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), backgroundColor: Colors.red),
//     );
//     setState(() {
//       _isLoading = false;
//     });
//   }
//   void _filterSearchResults(String query) {
//     if (query.isEmpty) {
//       setState(() => _filteredDetails = List.from(_userDetails));
//       return;
//     }
//     setState(() {
//       _filteredDetails = _userDetails.where((item) {
//         final name = (item['item_name'] ?? '').toString().toLowerCase();
//         return name.contains(query.toLowerCase());
//       }).toList();
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(375, 812),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           children: [
//             SizedBox(height: 100.h),
//             _buildCustomerInfo(),
//             _buildSearchBar(),
//             SizedBox(height: 10.h),
//             Expanded(child: _isLoading ? _buildLoadingIndicator() : _buildItemList()),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildSearchBar() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: TextField(
//         controller: _searchController,
//         onChanged: _filterSearchResults,
//         decoration: InputDecoration(
//           hintText: 'Search Item',
//           suffixIcon: _searchController.text.isNotEmpty
//               ? IconButton(
//                   icon: Icon(Icons.clear, color: Colors.grey),
//                   onPressed: () {
//                     _searchController.clear();
//                     _filterSearchResults('');
//                   },
//                 )
//               : null,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
//           filled: true,
//           fillColor: Colors.grey[200],
//           contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//         ),
//       ),
//     );
//   }
//   Widget _buildLoadingIndicator() {
//     return Center(child: CircularProgressIndicator());
//   }
//   Widget _buildItemList() {
//     return _filteredDetails.isNotEmpty
//         ? ListView.builder(
//             padding: EdgeInsets.all(16),
//             itemCount: _filteredDetails.length,
//             itemBuilder: (context, index) {
//               final item = _filteredDetails[index];
//               return Container(
//                 margin: EdgeInsets.only(bottom: 12),
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 2, blurRadius: 5, offset: Offset(0, 3)),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(item['item_name'] ?? 'No Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         SizedBox(height: 6.h),
//                         Text("Stock: ${item['item_qty'] ?? 'N/A'}  |  Price: ${item['item_price1'] ?? 'N/A'}",
//                             style: TextStyle(fontSize: 14)),
//                       ],
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.edit, color: Colors.blue),
//                       onPressed: () => showItemDialog(
//                         context,
//                         item,
//                         TextEditingController(),
//                         TextEditingController(),
//                         TextEditingController(),
//                         TextEditingController(),
//                         TextEditingController(),
//                         TextEditingController(),
//                         TextEditingController(),
//                         TextEditingController(),
//                         TextEditingController(),
//                         _updateItem,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           )
//         : Center(child: Text("No Data Found", style: TextStyle(fontSize: 16, color: Colors.grey)));
//   }
//   Widget _buildCustomerInfo() {
//     return Container(
//       width:  double.infinity,
//       margin: EdgeInsets.all(16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(color: const Color(0xFF8C8DF7), borderRadius: BorderRadius.circular(15)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(widget.userData['cust_name'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
//           SizedBox(height: 8.h),
//           Text("Address: ${widget.userData['cust_address']}", style: TextStyle(fontSize: 16, color: Colors.black)),
//           SizedBox(height: 8.h),
//           Text("Phone: ${widget.userData['cust_phone']}", style: TextStyle(fontSize: 16, color: Colors.black)),
//         ],
//       ),
//     );
//   }
//   void showItemDialog(BuildContext context, Map<String, dynamic> item,
//       TextEditingController stockController,
//       TextEditingController rateController,
//       TextEditingController qtyController,
//       TextEditingController offerController,
//       TextEditingController freeController,
//       TextEditingController remarksController,
//       TextEditingController discountController,
//       TextEditingController mrpController,
//       TextEditingController taxController,
//       Function(Map<String, dynamic>, Map<String, dynamic>) _updateItem) {
//     // Initialize controllers with existing values, handling nulls
//     stockController.text = item['item_qty']?.toString() ?? '';
//     rateController.text = item['item_price1']?.toString() ?? '';
//     qtyController.text = item['qty']?.toString() ?? '';
//     offerController.text = item['offer'] ?? '';
//     freeController.text = item['free']?.toString() ?? '';
//     remarksController.text = item['remarks'] ?? '';
//     discountController.text = item['discount']?.toString() ?? '';
//     mrpController.text = item['item_mrp']?.toString() ?? '';
//     taxController.text = item['tax']?.toString() ?? '';
//     // Calculate initial net rate
//     final netRate = calculateNetRate(
//       double.tryParse(rateController.text) ?? 0.0,
//       double.tryParse(discountController.text) ?? 0.0,
//     );
//     final netRateController = TextEditingController(text: netRate.toStringAsFixed(2)); // Display with 2 decimal places
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('${item['item_name'] ?? "Edit Item"}'),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(child: _buildInputField('Stock', stockController)),
//                     Expanded(child: _buildInputField('MRP', mrpController)),
//                     Expanded(child: _buildInputField('Tax', taxController)),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(child: _buildInputField('Rate', rateController)),
//                     Expanded(
//                       child: _buildInputField(
//                         'Net Rate',
//                         netRateController,
//                         enabled: false, // Make it non-editable
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(child: _buildInputField('Qty', qtyController)),
//                     Expanded(child: _buildInputField('Free', freeController)),
//                     Expanded(child: _buildInputField('Discount', discountController)),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(child: _buildInputField('Offer Remark', offerController)),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop(); // Close the dialog
//                       },
//                       child: Text('Cancel'),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         // 1. Collect the updated values
//                         final updatedItem = {
//                           'item_qty': int.tryParse(stockController.text) ?? 0,
//                           'item_price1': double.tryParse(rateController.text) ?? 0.0,
//                           'qty': int.tryParse(qtyController.text) ?? 0,
//                           'offer': offerController.text,
//                           'free': int.tryParse(freeController.text) ?? 0,
//                           'remarks': remarksController.text,
//                           'discount': double.tryParse(discountController.text) ?? 0.0,
//                           'item_mrp': double.tryParse(mrpController.text) ?? 0.0,
//                           'tax': double.tryParse(taxController.text) ?? 0.0,
//                         };
//                         // 2.  Handle Add logic here -  **Crucial:  Send updates to backend**
//                         _updateItem(item, updatedItem);
//                         Navigator.of(context).pop(); // Close the dialog
//                       },
//                       child: Text('Add'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//   Widget _buildInputField(String label, TextEditingController controller, {bool enabled = true}) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         controller: controller,
//         enabled: enabled, // Control the editability
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//         ),
//       ),
//     );
//   }
//   // **Important:**  Implement this function to actually update the data
//   Future<void> _updateItem(Map<String, dynamic> oldItem, Map<String, dynamic> newItem) async {
//     // 1.  Prepare your request body

//        SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userId = prefs.getString('user_id');
//     final requestBody = {
//       'comp_code': widget.compCode,
//       'user_id': userId,
//       'updated_data': newItem, // Send all the updated fields
//     };
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/orders'), // Replace with your actual endpoint
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(requestBody),
//       );
//       if (response.statusCode == 200) {
//         // Success!
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Item updated successfully!'), backgroundColor: Colors.green),
//         );
//         // Optionally, you can refresh the item list after a successful update
//         _fetchUserDetails(); // Reload data from the server
//       } else {
//         // API error
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to update item.  Status: ${response.statusCode}'), backgroundColor: Colors.red),
//         );
//       }
//     } catch (e) {
//       // Network error or other exception
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error updating item: $e'), backgroundColor: Colors.red),
//       );
//     }
//   }
//   // Function to calculate net rate after discount
//   double calculateNetRate(double rate, double discount) {
//     return rate - (rate * (discount / 100));
//   }
// }
