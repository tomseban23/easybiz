import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:easybizapp/pages/consts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Ensure this file exists and defines baseUrl

class UserDetailsPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String compCode;
  final String custType;

  const UserDetailsPage(
      {Key? key,
      required this.userData,
      required this.compCode,
      required this.custType})
      : super(key: key);

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  TextEditingController _searchController = TextEditingController();
  double itemTotal =  0;
  List<Map<String, dynamic>> _userDetails = [];
  List<Map<String, dynamic>> _filteredDetails = [];
  bool _isLoading = true;
  bool _showShopDetails = false;
  List<Map<String, dynamic>> _addedItems = [];
  List<Map<String, TextEditingController>> controllers = [];

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/shopdetails'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"comp_code": widget.compCode}),
      );
      //print("Response Body: ${response.body}"); // Debugging
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          setState(() {
            _userDetails = List<Map<String, dynamic>>.from(jsonData);
            _filteredDetails = List.from(_userDetails);
            _isLoading = false;
          });
        } else if (jsonData is Map<String, dynamic> &&
            jsonData.containsKey('details')) {
          setState(() {
            _userDetails = List<Map<String, dynamic>>.from(jsonData['details']);
            _filteredDetails = List.from(_userDetails);
            _isLoading = false;
          });
        } else {
          _showError("Unexpected data format");
        }
      } else {
        _showError("Failed to fetch details. Status: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Error fetching data: $e");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
    setState(() {
      _isLoading = false;
    });
  }

  void _filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() => _filteredDetails = List.from(_userDetails));
      return;
    }
    setState(() {
      _filteredDetails = _userDetails.where((item) {
        final name = (item['item_name'] ?? '').toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    });
  }

  // Helper function to format numbers with "k"
  String formatNumber(double number) {
    if (number >= 30000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toStringAsFixed(2);
  }

  // Calculate total of added items
  double _calculateTotal() {
    double total = 0;
    for (var item in _addedItems) {
      total += (double.tryParse(item['qty']?.toString() ?? '0') ?? 0) *
          (double.tryParse(item['item_price1']?.toString() ?? '0') ?? 0);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 100.h),
            _buildCustomerInfo(),
            _buildSearchBar(),
            SizedBox(height: 10.h),
            if (_showShopDetails)
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              _showShopDetails = false;
                            });
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: _isLoading
                          ? _buildLoadingIndicator()
                          : _buildItemList(),
                    ),
                  ],
                ),
              ),
            if (!_showShopDetails && _addedItems.isNotEmpty)
              Expanded(child: _buildAddedItemList()),
            if (!_showShopDetails && _addedItems.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    "Click on search bar to show items",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ),
            if (!_showShopDetails && _addedItems.isNotEmpty)
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8C8DF7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _submitOrder,
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min, // Keeps button size compact
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add Order',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 5), // Space between text and total
                        Text(
                          '₹${itemTotal.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _searchController,
        onTap: () {
          setState(() {
            _showShopDetails = true;
          });
        },
        onChanged: _filterSearchResults,
        decoration: InputDecoration(
          hintText: 'Search Item',
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    _filterSearchResults('');
                  },
                )
              : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildItemList() {
    return _filteredDetails.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _filteredDetails.length,
            itemBuilder: (context, index) {
              final item = _filteredDetails[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['item_name'] ?? 'No Name',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6.h),
                        Text(
                            "Stock: ${item['item_qty'] ?? 'N/A'}  |  Price: ${item['item_price1'] ?? 'N/A'}",
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.blue),
                      onPressed: () {
                        showItemDialog(
                          context,
                          item,
                          TextEditingController(),
                          TextEditingController(),
                          TextEditingController(),
                          TextEditingController(),
                          TextEditingController(),
                          TextEditingController(),
                          TextEditingController(),
                          TextEditingController(),
                          TextEditingController(),
                          TextEditingController(),
                          TextEditingController(),
                          _addItemToOrder,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          )
        : const Center(
            child: Text("No Data Found",
                style: TextStyle(fontSize: 16, color: Colors.grey)));
  }

  Widget _buildAddedItemList() {
    return _addedItems.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _addedItems.length,
            itemBuilder: (context, index) {
              final item = _addedItems[index];
              // Calculate total for the item
              double quantity =
                  double.tryParse(item['qty']?.toString() ?? '0') ?? 0;
              double price =
                  double.tryParse(item['item_price1']?.toString() ?? '0') ?? 0;
               itemTotal =  price;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['item_name'] ?? 'No Name',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6.h),
                        // *** MODIFICATION: Display Quantity and Total ***
                        Text(
                            "Quantity: ${item['qty'] ?? 'N/A'}  |  Total: ₹${itemTotal.toStringAsFixed(2)}", // Display quantity and calculated total
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                    Row(
                      // Add this Row widget
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            showItemDialog(
                              context,
                              item,
                              TextEditingController(),
                              TextEditingController(),
                              TextEditingController(),
                              TextEditingController(),
                              TextEditingController(),
                              TextEditingController(),
                              TextEditingController(),
                              TextEditingController(),
                              TextEditingController(),
                              TextEditingController(),
                              TextEditingController(),

                              _addItemToOrder, // use same function as adding
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDeleteItem(item),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          )
        : const Center(
            child: Text("No items added yet.",
                style: TextStyle(fontSize: 16, color: Colors.grey)));
  }

  Widget _buildCustomerInfo() {
    String? custType = widget.custType;
    Color badgeColor = Colors.transparent;
    String badgeText = '';

    if (custType == 'R') {
      badgeColor = Color(0xFFCDFD5D);
      ;
      badgeText = 'R';
    } else if (custType == 'W') {
      badgeColor = Color(0xFFE579B9);
      ;
      badgeText = 'W';
    }

    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF8C8DF7),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.userData['cust_name'],
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              // Text(
              //   "Type: ${custType ?? 'N/A'}",
              //   style: TextStyle(
              //     fontSize: 16,
              //     color: Colors.black,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Text(
                "Address: ${widget.userData['cust_address']}",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                "Phone: ${widget.userData['cust_phone']}",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
        if (badgeText.isNotEmpty)
          Positioned(
            top: 35,
            right: 35,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 13, vertical: 3),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                badgeText,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void showItemDialog(
      BuildContext context,
      Map<String, dynamic> item,
      TextEditingController stockController,
      TextEditingController rateController,
      TextEditingController netrateController,
      TextEditingController qtyController,
      TextEditingController offerController,
      TextEditingController freeController,
      TextEditingController remarksController,
      TextEditingController discountController,
      TextEditingController mrpController,
      TextEditingController taxController,
      TextEditingController subtotalController,
      Function(Map<String, dynamic>, Map<String, dynamic>) onAddItem) {
    //Calculating Netrate

    double tax = item['item_tax'].toDouble();
    double price = item['item_price1'].toDouble();
    double net_rate = price + (price * (tax / 100)).toDouble();

    //Calculating rate

    double rate = (net_rate * 100) / (tax + 100);
    print([rate, net_rate]);
    // Changed to onAddItem
    // Initialize controllers with existing values, handling nulls
    stockController.text = item['item_qty']?.toString() ?? '';
    rateController.text = rate?.toString() ?? '';
    netrateController.text = net_rate?.toString() ?? '';
    qtyController.text = item['qty']?.toString() ?? '';
    offerController.text = item['offer'] ?? '';
    freeController.text = item['free']?.toString() ?? '';
    remarksController.text = item['remarks'] ?? '';
    discountController.text = item['discount']?.toString() ?? '0';
    mrpController.text = item['item_mrp']?.toString() ?? '';
    taxController.text = item['item_tax']?.toString() ?? '';
    subtotalController.text = item['subtotal']?.toString() ?? '';

    // // Calculate initial net rate
    // final netRate = calculateNetRate(
    //   double.tryParse(rateController.text) ?? 0.0,
    //   double.tryParse(discountController.text) ?? 0.0,
    // );
    // final netRateController = TextEditingController(
    //     text: netRate.toStringAsFixed(2)); // Display with 2 decimal places

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${item['item_name'] ?? "Edit Item"}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: _buildInputField(
                            'Stock',
                            stockController,
                            enabled: false,
                            [
                          taxController,
                          rateController,
                          netrateController,
                          qtyController,
                          subtotalController,
                          discountController
                        ])),
                    Expanded(
                        child: _buildInputField(
                            'MRP',
                            mrpController,
                            enabled: false,
                            [
                          taxController,
                          rateController,
                          netrateController,
                          qtyController,
                          subtotalController,
                          discountController
                        ])),
                    Expanded(
                        child: _buildInputField('Tax', taxController, [
                      taxController,
                      rateController,
                      netrateController,
                      qtyController,
                      subtotalController,
                      discountController
                    ])),
                    Visibility(
                      child: Expanded(
                          child: _buildInputField('', subtotalController, [
                        taxController,
                        rateController,
                        netrateController,
                        qtyController,
                        subtotalController,
                        discountController
                      ])),
                      visible: false,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: _buildInputField('Rate', rateController, [
                      taxController,
                      rateController,
                      netrateController,
                      qtyController,
                      subtotalController,
                      discountController
                    ])),
                    Expanded(
                      child: _buildInputField('Net Rate', netrateController, [
                        taxController,
                        rateController,
                        netrateController,
                        qtyController,
                        subtotalController,
                        discountController
                      ]
                          //enabled: false, // Make it non-editable
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: _buildInputField('Quantity', qtyController, [
                      taxController,
                      rateController,
                      netrateController,
                      qtyController,
                      subtotalController,
                      discountController
                    ])),
                    Expanded(
                        child: _buildInputField('Free', freeController, [
                      taxController,
                      rateController,
                      netrateController,
                      qtyController,
                      subtotalController,
                      discountController
                    ])),
                    Expanded(
                        child:
                            _buildInputField('Discount', discountController, [
                      taxController,
                      rateController,
                      netrateController,
                      qtyController,
                      subtotalController,
                      discountController
                    ])),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child:
                            _buildInputField('Offer Remark', offerController, [
                      taxController,
                      rateController,
                      netrateController,
                      qtyController,
                      subtotalController,
                      discountController
                    ])),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        double ratefrom = double.parse(rateController.text);
                        double discfrom = double.parse(discountController.text);
                        double taxfrom = double.parse(taxController.text);
                        double qtyfrom = double.parse(qtyController.text);

                        double subtotal_target =
                            ratefrom - ratefrom * (discfrom / 100);

                        double subtotal = (subtotal_target +
                                (subtotal_target * (taxfrom / 100))) *
                            qtyfrom;
                        // 1. Collect the updated values
                        final updatedItem = {
                          'subtotal': subtotal,
                          'item_name': item['item_name'],
                          'item_qty': int.tryParse(stockController.text) ?? 0,
                          'item_price1':
                              double.tryParse(subtotal.toString()) ?? 0.0,
                          'qty': int.tryParse(qtyController.text) ?? 0,
                          'offer': offerController.text,
                          'free': int.tryParse(freeController.text) ?? 0,
                          'remarks': remarksController.text,
                          'discount':
                              double.tryParse(discountController.text) ?? 0,
                          'item_mrp':
                              double.tryParse(mrpController.text) ?? 0.0,
                          'item_tax':
                              double.tryParse(taxController.text) ?? 0.0,
                        };
                        // 2.  Handle Add logic here -  **Crucial:  Send updates to backend**
                        onAddItem(item, updatedItem); // Use onAddItem callback
                        Navigator.of(context).pop(); // Close the dialog
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Item added successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      List<TextEditingController> controllers,
      {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: (value) {
          //  [taxController,rateController,netrateController,qtyController,subtotalController,discountController]
         if (label == 'Rate') {
  double rate = double.tryParse(value) ?? 0.0;
  double tax = double.tryParse(controllers[0].text) ?? 0.0;
  double discount = double.tryParse(controllers[5].text) ?? 0.0;
  double quantity = double.tryParse(controllers[3].text) ?? 1.0; // Avoid division by zero

  double netrate = rate + (rate * tax / 100);
  double subtotaltarg = rate - (rate * discount / 100);
  double subtotal = (subtotaltarg + (subtotaltarg * tax / 100)) * quantity;

  controllers[2].text = netrate.toStringAsFixed(2);
  controllers[4].text = subtotal.toStringAsFixed(2);
}

if (label == 'Net Rate') {
  double netrate = double.tryParse(value) ?? 0.0;
  double tax = double.tryParse(controllers[0].text) ?? 0.0;
  double discount = double.tryParse(controllers[5].text) ?? 0.0;
  double quantity = double.tryParse(controllers[3].text) ?? 1.0;

  double rate = (netrate * 100) / (tax + 100);
  double subtotaltarg = rate - (rate * discount / 100);
  double subtotal = (subtotaltarg + (subtotaltarg * tax / 100)) * quantity;

  controllers[1].text = rate.toStringAsFixed(2);
  controllers[4].text = subtotal.toStringAsFixed(2);
}

if (label == 'Tax') {
  double tax = double.tryParse(value) ?? 0.0;
  double discount = double.tryParse(controllers[5].text) ?? 0.0;
  double quantity = double.tryParse(controllers[3].text) ?? 1.0;
  double rate = double.tryParse(controllers[1].text) ?? 0.0;

  double netrate = rate + (rate * tax / 100);
  double subtotaltarg = rate - (rate * discount / 100);
  double subtotal = (subtotaltarg + (subtotaltarg * tax / 100)) * quantity;

  controllers[2].text = netrate.toStringAsFixed(2);
  controllers[4].text = subtotal.toStringAsFixed(2);
}

if (label == 'Discount') {
  double discount = double.tryParse(value) ?? 0.0;
  double quantity = double.tryParse(controllers[3].text) ?? 1.0;
  double tax = double.tryParse(controllers[0].text) ?? 0.0;
  double rate = double.tryParse(controllers[1].text) ?? 0.0;

  double subtotaltarg = rate - (rate * discount / 100);
  double subtotal = (subtotaltarg + (subtotaltarg * tax / 100)) * quantity;

  controllers[4].text = subtotal.toStringAsFixed(2);
}

if (label == 'Quantity') {
  double quantity = double.tryParse(value) ?? 1.0;
  double tax = double.tryParse(controllers[0].text) ?? 0.0;
  double discount = double.tryParse(controllers[5].text) ?? 0.0;
  double rate = double.tryParse(controllers[1].text) ?? 0.0;

  double subtotaltarg = rate - (rate * discount / 100);
  double subtotal = (subtotaltarg + (subtotaltarg * tax / 100)) * quantity;

  controllers[4].text = subtotal.toStringAsFixed(2);
}

        },
        controller: controller,
        enabled: enabled, // Control the editability
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Modify _addItemToOrder to update _addedItems
  Future<void> _addItemToOrder(
      Map<String, dynamic> oldItem, Map<String, dynamic> newItem) async {
    setState(() {
      // Check if the item already exists in _addedItems
      int index = _addedItems.indexWhere((element) =>
          element['item_name'] ==
          oldItem['item_name']); // Use a unique identifier

      if (index >= 0) {
        // If it exists, update the existing item
        _addedItems[index] = newItem;
      } else {
        // If it doesn't exist, add the new item
        _addedItems.add(newItem);
      }
    });
  }

  // Submit the order to the backend
  Future<void> _submitOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');

    final requestBody = {
      'comp_code': widget.compCode,
      'user_id': userId,
      'order_details': _addedItems, // Send the list of added/edited items
    };
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/orders'), // Replace with your actual endpoint
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Success!
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Order submitted successfully!'),
              backgroundColor: Colors.green),
        );

        // Clear added items and refresh the shop details
        setState(() {
          _addedItems.clear();
          _showShopDetails = false; // Hide shop details after submission
        });

        _fetchUserDetails(); // Reload data from the server
      } else {
        // API error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to submit order.  Status: ${response.statusCode}'),
              backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      // Network error or other exception
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error submitting order: $e'),
            backgroundColor: Colors.red),
      );
    }
  }

  // Function to calculate net rate after discount
  double calculateNetRate(double rate, double discount) {
    return rate - (rate * (discount / 100));
  }

  // Function to confirm item deletion
  Future<void> _confirmDeleteItem(Map<String, dynamic> item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete ${item['item_name']}?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deleteItem(item);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to delete item from the added list
  void _deleteItem(Map<String, dynamic> item) {
    setState(() {
      _addedItems
          .removeWhere((element) => element['item_name'] == item['item_name']);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Item deleted successfully!'),
          backgroundColor: Colors.green),
    );
  }
}
