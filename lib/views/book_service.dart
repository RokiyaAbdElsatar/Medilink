import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medilink/constant/appcolor.dart';

class BookService extends StatefulWidget {
  const BookService({super.key});

  @override
  State<BookService> createState() => _BookServiceState();
}

class _BookServiceState extends State<BookService> {
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  String _selectedPayment = "Pay on Delivery";

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(AppColor.primary)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(AppColor.primary), width: 1.5),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = _selectedPayment == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPayment = title;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Color(AppColor.backGroundColor) : Colors.white,
          border: Border.all(
            color: isSelected
                ? Color(AppColor.primary)
                : Color(AppColor.primary).withOpacity(0.3),
            width: 1.2,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: Color(AppColor.primary),
            ),
            Icon(icon, color: Color(AppColor.primary), size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toLowerCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  BackButton(color: Color(AppColor.primary)),
                  const SizedBox(width: 8),
                  const Text(
                    "Book Service",
                    style: TextStyle(
                      color: Color(0xFF106B96),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Hospital Info
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(AppColor.backGroundColor),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "The Egyptian Hospital",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(
                          "4.5",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Icon(
                          Icons.pin_drop_outlined,
                          color: Color(0xFF106B96),
                          size: 16,
                        ),
                        Text(
                          " 0.8 Km away",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Service Details
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(AppColor.primary)),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Service Details",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    _infoRow("Service", "Home Doctor Visit"),
                    const SizedBox(height: 8),
                    _infoRow("Hospital", "The Egyptian Hospital"),
                    const SizedBox(height: 8),
                    _infoRow(
                      "Price",
                      "\$50 - \$100",
                      color: Color(AppColor.primary),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Appointment Details
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(AppColor.primary)),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Appointment Details",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    // Date
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: Color(AppColor.primary),
                        ),
                        SizedBox(width: 8),
                        Text("Date"),
                      ],
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: _pickDate,
                      decoration: _inputDecoration("mm / dd / yyyy"),
                    ),
                    const SizedBox(height: 10),

                    // Time
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Color(AppColor.primary)),
                        SizedBox(width: 8),
                        Text("Time"),
                      ],
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: _timeController,
                      readOnly: true,
                      onTap: _pickTime,
                      decoration: _inputDecoration("--:-- --"),
                    ),
                    const SizedBox(height: 10),

                    // Address
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Color(AppColor.primary),
                        ),
                        SizedBox(width: 8),
                        Text("Address"),
                      ],
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: _addressController,
                      decoration: _inputDecoration("Enter Your Address"),
                    ),
                    const SizedBox(height: 10),

                    // Contact Number
                    Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          color: Color(AppColor.primary),
                        ),
                        SizedBox(width: 8),
                        Text("Contact Number"),
                      ],
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: _contactController,
                      keyboardType: TextInputType.phone,
                      decoration: _inputDecoration("Enter Your Phone Number"),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              // Payment Method
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(AppColor.primary)),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Payment Method",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),

                    _buildPaymentOption(
                      title: "Pay on Delivery",
                      subtitle: "Pay when service is delivered",
                      icon: Icons.local_shipping_outlined,
                    ),
                    const SizedBox(height: 8),

                    _buildPaymentOption(
                      title: "Credit/Debit Card",
                      subtitle: "Pay securely with your card",
                      icon: Icons.credit_card,
                    ),
                    const SizedBox(height: 8),

                    _buildPaymentOption(
                      title: "Mobile Wallet",
                      subtitle: "Pay with digital wallet",
                      icon: Icons.account_balance_wallet,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint("Date: ${_dateController.text}");
                    debugPrint("Time: ${_timeController.text}");
                    debugPrint("Address: ${_addressController.text}");
                    debugPrint("Contact: ${_contactController.text}");
                    debugPrint("Payment Method: $_selectedPayment");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppColor.primary),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Confirm Appointment",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: color ?? Colors.black,
            fontWeight: color != null ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
