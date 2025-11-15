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
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const Text("My Bookings", style: TextStyle(color: Colors.white)),
        backgroundColor: blue,
        elevation: 0,
      ),
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
            padding: const EdgeInsets.all(16),
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
              IconData statusIcon;
              switch (status) {
                case 'accepted':
                  statusColor = Colors.green;
                  statusIcon = Icons.check_circle;
                  break;
                case 'rejected':
                  statusColor = Colors.redAccent;
                  statusIcon = Icons.cancel;
                  break;
                default:
                  statusColor = Colors.orange;
                  statusIcon = Icons.hourglass_top;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Colored status indicator
                    Container(
                      width: 6,
                      height: 140,
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(statusIcon, color: statusColor, size: 22),
                                const SizedBox(width: 8),
                                Text(
                                  service['title'] ?? 'Unknown Service',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: blue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Hospital: ${hospital['name'] ?? 'N/A'}",
                              style: const TextStyle(fontSize: 15),
                            ),
                            Text(
                              "Date: $formattedDate • Time: ${data['time']}",
                              style: const TextStyle(fontSize: 15),
                            ),
                            Text(
                              "Payment: ${data['paymentMethod']}",
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text(
                                  "Status: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  status.toUpperCase(),
                                  style: TextStyle(
                                    color: statusColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),

                            // 🔴 Inline rejection notice
                            if (status == 'rejected') ...[
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.redAccent.withOpacity(0.6),
                                  ),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.redAccent,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "The service you tried to book is not available now.",
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
