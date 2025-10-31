import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:medilink/views/drawer%20screen.dart';
import 'package:medilink/widgets/hospital_card.dart';

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

                        return hospitalCard(h: h, facilities: facilities);
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
