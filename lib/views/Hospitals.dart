import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:medilink/views/drawer%20screen.dart';

class Hospitals extends StatefulWidget {
  const Hospitals({super.key});

  @override
  State<Hospitals> createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {
  List<dynamic> hospitals = [];
  List<dynamic> filteredHospitals = [];
  bool isLoading = true;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchHospitals(); // Initial load
  }

  // Future<void> – Reload hospitals from API
  Future<void> fetchHospitals([String city = 'القاهرة']) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/hospitals?city=$city'),
        headers: {'User-Agent': 'HospitalFinder/1.0'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          hospitals = data['hospitals'];
          filteredHospitals = hospitals;
          isLoading = false;
          _searchController.clear();
          searchQuery = '';
        });
      } else {
        throw Exception('HTTP ${response.statusCode}');
      }
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('فشل تحميل المستشفيات'),
            backgroundColor: Colors.red.shade600,
          ),
        );
      }
    }
  }

  void filterHospitals(String query) {
    setState(() {
      searchQuery = query;
      filteredHospitals = hospitals.where((h) {
        final name = h['name'].toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerScreen(),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          "Hospitals",
          style: TextStyle(
            color: Color(0xFF0B7BA8),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            // Search Bar
            Container(
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFEBF4FF),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: filterHospitals,
                decoration: const InputDecoration(
                  hintText: "Search hospitals...",
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 15),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black54,
                    size: 22,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Grid or Loading
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredHospitals.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_hospital,
                            size: 60,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "لا توجد مستشفيات",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      itemCount: filteredHospitals.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.78,
                          ),
                      itemBuilder: (context, index) {
                        final h = filteredHospitals[index];
                        final facilities = h['facilities'] as List? ?? [];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    HospitalDetailScreen(hospital: h),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xFFE2F1FA),
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Image
                                Expanded(
                                  flex: 2,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                    child: facilities.isNotEmpty
                                        ? Image.network(
                                            facilities[0]['icon'],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            errorBuilder: (_, __, ___) =>
                                                Image.asset(
                                                  'assets/images/hospital_placeholder.png',
                                                  fit: BoxFit.cover,
                                                ),
                                          )
                                        : Image.asset(
                                            'assets/images/hospital_placeholder.png',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),

                                // Info
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          h['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: Colors.black87,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          "${h['distance_km']} km",
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: List.generate(
                                            5,
                                            (i) => Icon(
                                              i < (h['rating'] as num).toInt()
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color: const Color(0xFFFFC107),
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        if (facilities.isNotEmpty)
                                          Wrap(
                                            spacing: 4,
                                            children: facilities
                                                .take(3)
                                                .map<Widget>((f) {
                                                  return CircleAvatar(
                                                    radius: 10,
                                                    backgroundImage:
                                                        NetworkImage(f['icon']),
                                                    backgroundColor:
                                                        Colors.grey.shade200,
                                                  );
                                                })
                                                .toList(),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // Reload FAB – Calls Future<void> fetchHospitals()
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await fetchHospitals(); // Now properly awaited
        },
        backgroundColor: const Color(0xFF0B7BA8),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}

// ========================================
// Hospital Detail Screen (Unchanged)
// ========================================
class HospitalDetailScreen extends StatelessWidget {
  final Map<String, dynamic> hospital;

  const HospitalDetailScreen({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    final facilities = hospital['facilities'] as List? ?? [];
    final homeServices = hospital['home_services'] as List? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(hospital['name']),
        backgroundColor: const Color(0xFF0B7BA8),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (facilities.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  facilities[0]['icon'],
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Image.asset('assets/images/hospital_placeholder.png'),
                ),
              ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    hospital['name'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${hospital['rating']}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),
            Text(
              hospital['address'],
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.phone, size: 16, color: Colors.blue),
                const SizedBox(width: 4),
                Text(
                  hospital['phone'],
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.red),
                const SizedBox(width: 4),
                Text("${hospital['distance_km']} km away"),
              ],
            ),

            const Divider(height: 32),
            const Text(
              "Facilities",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: facilities.map<Widget>((f) {
                return Chip(
                  avatar: CircleAvatar(
                    backgroundImage: NetworkImage(f['icon']),
                  ),
                  label: Text(f['name'], style: const TextStyle(fontSize: 12)),
                );
              }).toList(),
            ),

            const Divider(height: 32),
            const Text(
              "Home Services",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...homeServices.map<Widget>((s) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(s['icon']),
                  ),
                  title: Text(s['title']),
                  subtitle: Text(s['description']),
                  trailing: Text(
                    s['price_range'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              );
            }).toList(),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B7BA8),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Book Now", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
