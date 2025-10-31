import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/views/booking_servies.dart';
import 'package:medilink/views/notification_screen.dart';
import 'package:medilink/widgets/custom_app_bar.dart';

class HospitalDetailScreen extends StatefulWidget {
  final Map<String, dynamic> hospital;

  const HospitalDetailScreen({super.key, required this.hospital});

  @override
  State<HospitalDetailScreen> createState() => _HospitalDetailScreenState();
}

class _HospitalDetailScreenState extends State<HospitalDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Only 2 tabs now
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final facilities = widget.hospital['facilities'] as List? ?? [];
    final homeServices = widget.hospital['home_services'] as List? ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: widget.hospital['name'],
        subtitle: widget.hospital['address'],
        icon: Icons.notifications_outlined,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationScreen()),
          );
        },
        shape: BoxShape.circle,
      ),
      body: Column(
        children: [
          // === HOSPITAL CARD (as in image) ===
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      "${widget.hospital['rating']}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    const Icon(Icons.location_on, color: Colors.blue, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      "${widget.hospital['distance_km']} km away",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // === TAB BAR ===
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF0B7BA8),
              unselectedLabelColor: Colors.black54,
              indicator: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Color(0xFFE3F4FA),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              tabs: const [
                Tab(text: "Details"),
                Tab(text: "Services"),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // === TAB VIEWS ===
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDetailsTab(facilities),
                _buildServicesTab(homeServices),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // === DETAILS TAB ===
  Widget _buildDetailsTab(List facilities) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Contact Information",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            Icons.location_on,
            widget.hospital['address'],
            "Visit here",
          ),
          _buildInfoRow(Icons.phone, widget.hospital['phone'], null),
          _buildInfoRow(Icons.access_time, "24/7", null),

          const SizedBox(height: 24),

          const Text(
            "Facilities",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: facilities.map<Widget>((f) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5FBFF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Image.network(
                      f['icon'],
                      width: 36,
                      height: 36,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.local_hospital, size: 36),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    f['name'],
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, String? action) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF0B7BA8)),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
          if (action != null)
            Text(
              action,
              style: const TextStyle(color: Color(0xFF0B7BA8), fontSize: 12),
            ),
        ],
      ),
    );
  }

  // === SERVICES TAB ===
  Widget _buildServicesTab(List homeServices) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: homeServices.length,
      itemBuilder: (context, index) {
        final service = homeServices[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5FBFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network(
                  service['icon'],
                  width: 32,
                  height: 32,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.medical_services, size: 32),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service['description'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service['price_range'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(AppColor.primary),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingScreen(
                        hospital: widget.hospital,
                        service: service,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B7BA8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  "Book Now",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// === BOOKING SCREEN (unchanged) ===
