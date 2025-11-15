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
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Admin Dashboard",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 0.5,
                color: Colors.white,
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(AppColor.primary), Color(0xFF1E88E5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            },
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
            return const Center(
              child: Text(
                "No bookings found.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final bookings = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: bookings.length,
            itemBuilder: (context, i) {
              final booking = bookings[i];
              final data = booking.data() as Map<String, dynamic>;
              final hospital = data['hospital'] ?? {};
              final service = data['service'] ?? {};
              final date = (data['date'] as Timestamp).toDate();
              final formattedDate = DateFormat('MM/dd/yyyy').format(date);
              final status = data['status'] ?? 'pending';

              Color statusColor;
              switch (status) {
                case 'accepted':
                  statusColor = Colors.green;
                  break;
                case 'rejected':
                  statusColor = Colors.red;
                  break;
                default:
                  statusColor = Colors.orange;
              }

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Colors.white, Color(0xFFF4F7FA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: const Color(
                        AppColor.primary,
                      ).withOpacity(0.1),
                      radius: 26,
                      child: Icon(
                        Icons.medical_services_rounded,
                        color: Color(AppColor.primary),
                        size: 28,
                      ),
                    ),
                    title: Text(
                      service['title'] ?? 'Unknown Service',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF0B7BA8),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoRow(
                            Icons.local_hospital,
                            "Hospital",
                            hospital['name'] ?? 'N/A',
                          ),
                          _infoRow(Icons.calendar_today, "Date", formattedDate),
                          _infoRow(Icons.access_time, "Time", data['time']),
                          _infoRow(
                            Icons.payment,
                            "Payment",
                            data['paymentMethod'] ?? 'N/A',
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                size: 18,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: statusColor),
                                ),
                                child: Text(
                                  status.toUpperCase(),
                                  style: TextStyle(
                                    color: statusColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    trailing: PopupMenuButton<String>(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
                          child: Row(
                            children: [
                              Icon(Icons.check, color: Colors.green),
                              SizedBox(width: 8),
                              Text("Accept"),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: "rejected",
                          child: Row(
                            children: [
                              Icon(Icons.close, color: Colors.red),
                              SizedBox(width: 8),
                              Text("Reject"),
                            ],
                          ),
                        ),
                      ],
                      icon: const Icon(Icons.more_vert, color: Colors.black54),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 6),
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
