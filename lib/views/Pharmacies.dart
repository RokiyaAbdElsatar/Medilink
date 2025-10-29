import 'package:flutter/material.dart';
import 'package:medilink/views/drawer%20screen.dart';

class Pharmacies extends StatefulWidget {
  const Pharmacies({super.key});

  @override
  State<Pharmacies> createState() => _PharmaciesState();
}

final List<Map<String, String>> pharmacies = [
  {
    'name': 'Misr Pharmacies',
    'branches': '200+ Branches',
    'image': 'assets/images/pharm1.png',
  },
  {
    'name': 'El-Ezaby Pharmacy',
    'branches': '330+ Branches',
    'image': 'assets/images/pharm2.png',
  },
  {
    'name': 'Dawaee Pharmacies',
    'branches': '50+ Branches',
    'image': 'assets/images/pharm3.png',
  },
  {
    'name': 'Ali & Ali Pharmacy',
    'branches': '40+ Branches',
    'image': 'assets/images/pharm4.png',
  },
  {
    'name': 'Ali & Ali Pharmacy',
    'branches': '40+ Branches',
    'image': 'assets/images/pharm5.png',
  },
  {
    'name': 'Ali & Ali Pharmacy',
    'branches': '40+ Branches',
    'image': 'assets/images/pharm6.png',
  },
];

class _PharmaciesState extends State<Pharmacies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerScreen(),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,

        title: const Text(
          "Pharmacies",
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
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search",
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

            // Pharmacy Grid
            Expanded(
              child: GridView.builder(
                itemCount: pharmacies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final item = pharmacies[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFE2F1FA)),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            child: Image.asset(
                              item['image']!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item['name']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['branches']!,
                                textAlign: TextAlign.center,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
