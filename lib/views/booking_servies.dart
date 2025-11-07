import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/services/booking_service.dart';
import 'package:medilink/views/notification_screen.dart';
import 'package:medilink/widgets/custom_app_bar.dart';

enum PaymentMethod { cod, card, wallet }

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> hospital;
  final Map<String, dynamic> service;

  const BookingScreen({
    super.key,
    required this.hospital,
    required this.service,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateCtrl = TextEditingController();
  final _timeCtrl = TextEditingController();
  final _addrCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _cardNumberCtrl = TextEditingController();
  final _cardExpiryCtrl = TextEditingController();
  final _cardCVVCtrl = TextEditingController();
  final _walletPhoneCtrl = TextEditingController();
  final _bookingService = BookingService();

  DateTime? _date;
  TimeOfDay? _time;
  PaymentMethod? _payment = PaymentMethod.cod;

  static const Color blue = Color(0xFF0B7BA8);

  @override
  void dispose() {
    _dateCtrl.dispose();
    _timeCtrl.dispose();
    _addrCtrl.dispose();
    _phoneCtrl.dispose();
    _cardNumberCtrl.dispose();
    _cardExpiryCtrl.dispose();
    _cardCVVCtrl.dispose();
    _walletPhoneCtrl.dispose();
    super.dispose();
  }

  bool get _isValid {
    final baseValid =
        _date != null &&
        _time != null &&
        _addrCtrl.text.trim().isNotEmpty &&
        RegExp(r'^\d{10}$').hasMatch(_phoneCtrl.text.trim());

    if (_payment == PaymentMethod.cod) return baseValid;
    if (_payment == PaymentMethod.card) {
      return baseValid &&
          _cardNumberCtrl.text.trim().length == 16 &&
          _cardExpiryCtrl.text.trim().length == 5 &&
          _cardCVVCtrl.text.trim().length == 3;
    }
    if (_payment == PaymentMethod.wallet) {
      return baseValid &&
          RegExp(r'^\d{10}$').hasMatch(_walletPhoneCtrl.text.trim());
    }
    return false;
  }

  void _clearAll() {
    setState(() {
      _date = _time = null;
      _payment = PaymentMethod.cod;
    });
    _dateCtrl.clear();
    _timeCtrl.clear();
    _addrCtrl.clear();
    _phoneCtrl.clear();
    _cardNumberCtrl.clear();
    _cardExpiryCtrl.clear();
    _cardCVVCtrl.clear();
    _walletPhoneCtrl.clear();
    _formKey.currentState?.reset();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (ctx, child) => Theme(
        data: Theme.of(
          ctx,
        ).copyWith(colorScheme: const ColorScheme.light(primary: blue)),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _date = picked;
        _dateCtrl.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(
          ctx,
        ).copyWith(colorScheme: const ColorScheme.light(primary: blue)),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _time = picked;
        _timeCtrl.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Book Service",
        icon: Icons.notifications_outlined,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NotificationScreen()),
        ),
        shape: BoxShape.circle,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hospital Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5FBFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_hospital, size: 30, color: blue),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.hospital['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(AppColor.medicationColor),
                            ),
                          ),
                          Text(
                            "${widget.hospital['rating']} • ${widget.hospital['distance_km']} km away",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Service Details
              const Text(
                "Service Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(AppColor.medicationColor),
                ),
              ),
              const SizedBox(height: 12),
              _row("Service", widget.service['title']),
              _row("Hospital", widget.hospital['name']),
              _row("Price", widget.service['price_range']),
              const SizedBox(height: 20),

              // Appointment Details
              const Text(
                "Appointment Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(AppColor.medicationColor),
                ),
              ),
              const SizedBox(height: 12),
              _pickerField(
                _dateCtrl,
                "mm / dd / yyyy",
                Icons.calendar_today,
                _pickDate,
                _date == null ? "Select date" : null,
              ),
              const SizedBox(height: 12),
              _pickerField(
                _timeCtrl,
                "--:--",
                Icons.access_time,
                _pickTime,
                _time == null ? "Select time" : null,
              ),
              const SizedBox(height: 12),
              _textField(
                _addrCtrl,
                "Enter Your Address",
                Icons.location_on,
                TextInputType.text,
                (v) => v?.trim().isEmpty ?? true ? "Enter address" : null,
              ),
              const SizedBox(height: 12),
              _textField(
                _phoneCtrl,
                "Contact Number (10 digits)",
                Icons.phone,
                TextInputType.phone,
                (v) {
                  if (v?.trim().isEmpty ?? true) return "Enter phone";
                  if (!RegExp(r'^\d{10}$').hasMatch(v!.trim()))
                    return "10 digits only";
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Payment Method
              const Text(
                "Payment Method",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(AppColor.medicationColor),
                ),
              ),
              const SizedBox(height: 12),
              _paymentOption(
                PaymentMethod.cod,
                Icons.local_shipping,
                "Pay on Delivery",
                "Pay when service is delivered",
              ),
              _paymentOption(
                PaymentMethod.card,
                Icons.credit_card,
                "Credit/Debit Card",
                "Pay securely with your card",
              ),
              _paymentOption(
                PaymentMethod.wallet,
                Icons.account_balance_wallet,
                "Mobile Wallet",
                "Pay with digital wallet",
              ),
              const SizedBox(height: 16),

              // Conditional Fields
              if (_payment == PaymentMethod.card) ...[
                _cardInput(
                  "Card Number",
                  _cardNumberCtrl,
                  TextInputType.number,
                  (v) => v?.trim().length != 16 ? "16 digits required" : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _cardInput(
                        "MM/YY",
                        _cardExpiryCtrl,
                        TextInputType.datetime,
                        (v) => v?.trim().length != 5 ? "Invalid" : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _cardInput(
                        "CVV",
                        _cardCVVCtrl,
                        TextInputType.number,
                        (v) => v?.trim().length != 3 ? "3 digits" : null,
                      ),
                    ),
                  ],
                ),
              ] else if (_payment == PaymentMethod.wallet) ...[
                _textField(
                  _walletPhoneCtrl,
                  "Wallet Phone Number",
                  Icons.phone_android,
                  TextInputType.phone,
                  (v) {
                    if (v?.trim().isEmpty ?? true) return "Enter phone";
                    if (!RegExp(r'^\d{10}$').hasMatch(v!.trim()))
                      return "10 digits only";
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 30),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isValid
                      ? () async {
                          if (_formKey.currentState!.validate()) {
                            final method = _payment == PaymentMethod.cod
                                ? "COD"
                                : _payment == PaymentMethod.card
                                ? "CARD"
                                : "WALLET";

                            try {
                              await _bookingService.addBooking(
                                hospital: widget.hospital,
                                service: widget.service,
                                date: _date!,
                                time: _time!.format(context),
                                address: _addrCtrl.text.trim(),
                                phone: _phoneCtrl.text.trim(),
                                paymentMethod: method,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Booking added successfully!"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              _clearAll();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Error: $e"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    disabledBackgroundColor: Colors.grey[400],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Confirm Booking",
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

  // Reusable Row
  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.black54)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );

  // Payment Option
  Widget _paymentOption(
    PaymentMethod value,
    IconData icon,
    String title,
    String subtitle,
  ) => Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: _payment == value ? blue : Colors.grey.shade300,
        width: _payment == value ? 2 : 1,
      ),
    ),
    child: RadioListTile<PaymentMethod>(
      value: value,
      groupValue: _payment,
      onChanged: (val) => setState(() => _payment = val),
      activeColor: blue,
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Icon(icon, size: 24, color: blue),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ],
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: Colors.black54),
      ),
    ),
  );

  // Card Input Field
  Widget _cardInput(
    String hint,
    TextEditingController ctrl,
    TextInputType type,
    String? Function(String?) validator,
  ) => TextFormField(
    controller: ctrl,
    keyboardType: type,
    style: const TextStyle(color: blue),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.grey[50],
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(width: 2),
    ),
    validator: validator,
    onChanged: (_) => setState(() {}),
  );

  // Picker Field
  Widget _pickerField(
    TextEditingController ctrl,
    String hint,
    IconData icon,
    VoidCallback onTap,
    String? error,
  ) => TextField(
    controller: ctrl,
    readOnly: true,
    onTap: onTap,
    style: const TextStyle(color: blue),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, size: 20, color: blue),
      suffixIcon: const Icon(Icons.arrow_drop_down, color: blue),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(width: 2),
      errorText: error,
      errorBorder: _border(color: Colors.red),
    ),
  );

  // Text Field
  Widget _textField(
    TextEditingController ctrl,
    String hint,
    IconData icon,
    TextInputType? type,
    String? Function(String?) validator,
  ) => TextFormField(
    controller: ctrl,
    keyboardType: type,
    style: const TextStyle(color: blue),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, size: 20, color: blue),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(width: 2),
    ),
    validator: validator,
    onChanged: (_) => setState(() {}),
  );

  OutlineInputBorder _border({double width = 1, Color color = blue}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );
}
