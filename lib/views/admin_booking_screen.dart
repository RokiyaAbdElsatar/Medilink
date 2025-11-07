import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/services/booking_service.dart';
import 'package:intl/intl.dart';
import 'package:medilink/views/login_screen.dart';

class AdminBookingScreen extends StatelessWidget {
  final _bookingService = BookingService();

  AdminBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Bookings"),
        backgroundColor: const Color(AppColor.primary),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _bookingService.getAllBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No bookings found."));
          }

          final bookings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, i) {
              final booking = bookings[i];
              final data = booking.data() as Map<String, dynamic>;
              final hospital = data['hospital'] ?? {};
              final service = data['service'] ?? {};
              final date = (data['date'] as Timestamp).toDate();
              final formattedDate = date != null
                  ? DateFormat('MM/dd/yyyy').format(date)
                  : 'N/A';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    "${service['title'] ?? 'Unknown Service'}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B7BA8),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hospital: ${hospital['name'] ?? 'N/A'}"),
                      Text("Date: $formattedDate, Time: ${data['time']}"),
                      Text("Payment: ${data['paymentMethod']}"),
                      Text(
                        "Status: ${data['status']}",
                        style: TextStyle(
                          color: data['status'] == 'accepted'
                              ? Colors.green
                              : data['status'] == 'rejected'
                              ? Colors.red
                              : Colors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) async {
                      await _bookingService.updateBookingStatus(
                        bookingId: booking.id,
                        newStatus: value,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Booking marked as $value"),
                          backgroundColor: value == "accepted"
                              ? Colors.green
                              : Colors.red,
                        ),
                      );
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: "accepted",
                        child: Text("Accept"),
                      ),
                      const PopupMenuItem(
                        value: "rejected",
                        child: Text("Reject"),
                      ),
                    ],
                    icon: const Icon(Icons.more_vert),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
