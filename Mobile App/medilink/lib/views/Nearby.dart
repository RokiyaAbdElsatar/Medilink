import 'package:flutter/material.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({super.key});

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  int _selectedIndex = 0;
  String selectedCategory = 'All';
  String selectedSort = "distance";

  final List<Map<String, String>> pharmacies = [
    {
      'name': 'Misr Pharmacies',
      'branches': '200+ Branches',
      'image': 'image/download (1).png',
      'type': 'Pharmacy',
    },
    {
      'name': 'El-Ezaby Pharmacy',
      'branches': '330+ Branches',
      'image': 'image/download (2).png',
      'type': 'Pharmacy',
    },
    {
      'name': 'Dawaee Pharmacies',
      'branches': '50+ Branches',
      'image': 'image/download.png',
      'type': 'Pharmacy',
    },
  ];

  final List<Map<String, String>> hospitals = [
    {
      'name': 'Cairo Hospital',
      'branches': '50+ Branches',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/1/15/Misr_Pharmacies_logo.png',
      'type': 'Hospital',
    },
    {
      'name': 'Dar Al Fouad Hospital',
      'branches': '30+ Branches',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/6/6e/Dawaee_logo.png',
      'type': 'Hospital',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final allItems = [...pharmacies, ...hospitals];

    final filteredItems = selectedCategory == 'All'
        ? allItems
        : allItems
            .where((item) => item['type'] == selectedCategory)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nearby",
          style: TextStyle(
            color: Color(0xFF20A0D8),
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 194, 230, 241),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.black, size: 28),
                  hintText: "Search",
                  hintStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 🟦 أزرار الفلترة
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildFilterButton("All"),
                const SizedBox(width: 12),
                buildFilterButton("Hospital"),
                const SizedBox(width: 12),
                buildFilterButton("Pharmacy"),
              ],
            ),

            const SizedBox(height: 16),
SizedBox(height: 12,),
 Center(
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      border: Border.all(color: const Color(0xFF20A0D8), width: 1.5),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.sort, color: Color(0xFF20A0D8), size: 22),
        SizedBox(width: 8),

        GestureDetector(
          onTap: () {
            setState(() {
              selectedSort = "distance";
            });
          },
          child: Container(
            padding:  EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Sort By Distance",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        Container(
          width: 1,
          height: 20,
          color: Colors.grey.shade300,
          margin: const EdgeInsets.symmetric(horizontal: 8),
        ),

        GestureDetector(
          onTap: () {
            setState(() {
              selectedSort = "rating";
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              
            ),
            child:
             Row(
               children: [
                Icon(Icons.star_border,  color:const Color.fromARGB(255, 0, 0, 0), size: 22),
                 Text(
                  "Sort By Rating",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                             ),
               ],
             ),
            
          ),
        ),
      ],
    ),
  ),
),

SizedBox(height: 15,),

            Expanded(
              child: GridView.builder(
                itemCount: filteredItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  final isNetworkImage =
                      item['image']!.startsWith('http'); // للتحقق من نوع الصورة

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFBFE4F1),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: isNetworkImage
                                  ? Image.network(item['image']!,
                                      fit: BoxFit.contain)
                                  : Image.asset(item['image']!,
                                      fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text(
                                item['name']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['branches'] ?? '',
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

  // 🟢 Widget للفلاتر
  Widget buildFilterButton(String label) {
    final bool isSelected = selectedCategory == label;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool value) {
        setState(() {
          selectedCategory = label;
        });
      },
      selectedColor: Colors.lightBlue,
      backgroundColor: Colors.white,
      labelStyle:
          TextStyle(color: isSelected ? Colors.white : Colors.lightBlue),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFF20A0D8)),
      ),
    );
  }
}
