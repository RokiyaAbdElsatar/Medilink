import 'package:flutter/material.dart';
import 'package:medilink/views/Pharmacies.dart';

class Hospitals extends StatefulWidget {
  const Hospitals({super.key});

  @override
  State<Hospitals> createState() => _HospitalsState();
}
int _selectedIndex = 0;
 final List<Map<String, String>> Hospital= [
      {
        'name': 'Cairo Hospital',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/1/15/Misr_Pharmacies_logo.png',
      },
      {
        'name': 'Ain Shams Hospital',
        'branches': '330+ Branches',
        'image': 'https://upload.wikimedia.org/wikipedia/en/3/31/El_Ezaby_Pharmacy_logo.png',
      },
      {
        'name': 'Al Salam International Hospital',
        'branches': '50+ Branches',
        'image': 'https://upload.wikimedia.org/wikipedia/en/6/6e/Dawaee_logo.png',
      },
      {
        'name': 'Dar Al Fouad Hospital',
        'branches': '40+ Branches',
        'image': 'https://upload.wikimedia.org/wikipedia/en/d/d0/Pharmacy_logo.png',
      },
      {
        'name': 'Future Hospital',
        'branches': '40+ Branches',
        'image': 'https://upload.wikimedia.org/wikipedia/en/d/d0/Pharmacy_logo.png',
      },
    ];

class _HospitalsState extends State<Hospitals> {
  @override
  Widget build(BuildContext context) {
    int  _selectedIndex=0;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.list),
        title: Text("Hospitals",style: TextStyle(
          color: Color(0xFF20A0D8),fontSize: 21,fontWeight: FontWeight.bold
        ),
        ),
        centerTitle: true,
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
                  itemCount: Hospital.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final item =Hospital[index];
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
                                child: Image.network(
                                  item['image']!,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.local_pharmacy,
                                          color: Colors.grey, size: 40),
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
      currentIndex: _selectedIndex,
      onTap: (index) {
        if (index == 0) {
          Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => Pharmacies()),
          );
        } else {
          setState(() {
            _selectedIndex = index;
          });
        }
      },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2B7EA1),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            activeIcon: Icon(Icons.medical_services),
            label: 'Hospitals',
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
  