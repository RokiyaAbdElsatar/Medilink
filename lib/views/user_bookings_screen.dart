import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/services/booking_service.dart';

class UserBookingsScreen extends StatelessWidget {
  final _bookingService = BookingService();

  UserBookingsScreen({super.key});

  static const Color blue = Color(AppColor.primary);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: const Text("My Bookings", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(AppColor.primary),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: _bookingService.getUserBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "You haven’t made any bookings yet.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }

          final bookings = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
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
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.local_hospital, color: blue),
                  title: Text(
                    service['title'] ?? 'Unknown Service',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: blue,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hospital: ${hospital['name'] ?? 'N/A'}"),
                        Text("Date: $formattedDate at ${data['time']}"),
                        Text("Payment: ${data['paymentMethod']}"),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Text("Status: "),
                            Text(
                              status.toUpperCase(),
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
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
}
