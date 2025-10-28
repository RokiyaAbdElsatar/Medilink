import 'package:flutter/material.dart';

import 'Hospitals.dart' show Hospitals;

class Pharmacies extends StatefulWidget {
   Pharmacies({super.key});
  

  @override
  State<Pharmacies> createState() => _PharmaciesState();
}
int _selectedIndex = 0;
 final List<Map<String, String>> pharmacies = [
      {
        'name': 'Misr Pharmacies',
        'branches': '200+ Branches',
        'image': 'image/download (1).png',
      },
      {
        'name': 'El-Ezaby Pharmacy',
        'branches': '330+ Branches',
        'image': 'image/download (2).png',
      },
      {
        'name': 'Dawaee Pharmacies',
        'branches': '50+ Branches',
        'image': 'image/download.png',
      },
      {
        'name': 'Ali & Ali Pharmacy',
        'branches': '40+ Branches',
        'image': 'image/images (1).png',
      },
      {
        'name': 'Ali & Ali Pharmacy',
        'branches': '40+ Branches',
        'image': 'image/images.jpeg',
      },
      {
        'name': 'Ali & Ali Pharmacy',
        'branches': '40+ Branches',
        'image': 'image/images.png',
      },
    ];
     String selectedSort = "distance";

class _PharmaciesState extends State<Pharmacies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back,color: Colors.blue,),
        title: Text("Pharmacies",style: TextStyle(
          color: Color(0xFF20A0D8),fontSize: 21,fontWeight: FontWeight.bold
        ),
        ),
        centerTitle: false,
      ),
     body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 350,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 194, 230, 241),
                  borderRadius: BorderRadius.circular(20),
                ),
                child:  TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.black,size: 28,),
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                  ),
                ),
                        ),
            ),

            SizedBox(height: 12,),
                            Expanded(
              child: SingleChildScrollView(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: pharmacies.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final item = pharmacies[index];
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
                                child: Image.asset(
                                  item['image']!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(14),
                              ),
                            ),
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
                                  item['branches']!,
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
            ),
        ],
       ),
     ) ,
     bottomNavigationBar: Container( 
  height: 70, 
  decoration: const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(24), 
      topRight: Radius.circular(24), 
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        spreadRadius: 2,
        offset: Offset(0, -2),
      ),
    ],
  ),
  child: ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
    ),
    child: BottomNavigationBar( 
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2B7EA1),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 10,
        currentIndex: _selectedIndex, 
        onTap: (index) {              
        setState(() {
       _selectedIndex = index;
    });

      if (index == 1) { 
         Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Hospitals()),
      );
    }
  },
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            activeIcon: Icon(Icons.medical_services),
            label: 'Nearby',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            activeIcon: Icon(Icons.local_hospital),
            label: 'Ai chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            activeIcon: Icon(Icons.smart_toy),
            label: 'Medicine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    )));
  }
}
  