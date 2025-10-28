import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final Map<String, String> item; 

  const Details({super.key, required this.item});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int selectedTab = 0; 

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final String type = item['type'] ?? "Facility"; 

    return Scaffold(
      appBar: AppBar(
        title: Text(
          type == "Hospital" ? "Hospitals" : "Pharmacies",
          style: TextStyle(
            color: Color(0xFF20A0D8),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme:  IconThemeData(color: Color(0xFF20A0D8)),
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
              color:  Color(0xFFE9F6FC),
              borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'] ?? 'Facility Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                   SizedBox(height: 4),
                  Row(
                    children:[
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 4),
                      Text("4.5"),
                      SizedBox(width: 12),
                      Icon(Icons.location_on_outlined,
                          color: Colors.grey, size: 18),
                      SizedBox(width: 4),
                      Text("0.8 Km away"),
                    ],
                  ),
                ],
              ),
            ),
             SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTabButton("Details", 0),
                buildTabButton("Services", 1),
                buildTabButton("Reviews", 2),
              ],
            ),
             SizedBox(height: 16),
            if (selectedTab == 0) buildDetailsTab(),
            if (selectedTab == 1) buildServicesTab(),
            if (selectedTab == 2) buildReviewsTab(),
          ],
        ),
      ),
    );
  }
  Widget buildTabButton(String text, int index) {
    final bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selectedTab = index);
        },
        child: Container(
          padding:  EdgeInsets.symmetric(vertical: 10),
          margin:  EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ?  Color(0xFF20A0D8) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color:  Color(0xFF20A0D8)),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Color(0xFF20A0D8),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildDetailsTab() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color:  Color(0xFF20A0D8), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              "Contact Information",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.blue),
            ),
           SizedBox(height: 8),
            buildInfoCard(
              icon: Icons.location_on_outlined,
              title: "Address",
              subtitle: "123 Main Street, Downtown",
              trailing: "Visit now",
            ),
            SizedBox(height: 8),
            buildInfoCard(
              icon: Icons.phone,
              title: "Phone",
              subtitle: "+20 1095699999",
            ),
             SizedBox(height: 8),
            buildInfoCard(
              icon: Icons.access_time,
              title: "Working Hours",
              subtitle: "24/7",
            ),
          ],
        ),
      ),

       SizedBox(height: 15),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color:  Color(0xFF20A0D8), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Facilities",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.blue),
            ),
             SizedBox(height: 10),
            buildInfoCard(
              icon: Icons.local_hospital_outlined,
              title: "Intensive Care Unit",
              subtitle: "",
            ),
             SizedBox(height: 12),
            buildInfoCard(
              icon: Icons.emergency_outlined,
              title: "Emergency Care",
              subtitle: "",
            ),

             SizedBox(height: 15),
            buildInfoCard(
              icon: Icons.medical_services_outlined,
              title: "Surgery",
              subtitle: "",
            ),
            
             SizedBox(height: 12),
              buildInfoCard(
              icon: Icons.local_pharmacy_outlined,
              title: "Pharmacy",
              subtitle: "",
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildInfoCard({
  required IconData icon,
  required String title,
  required String subtitle,
  String? trailing,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color:  Color(0xFF20A0D8)),
       SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style:  TextStyle(color: Colors.black54)),
          ],
        ),
      ),
      if (trailing != null)
        Text(
          trailing,
          style:  TextStyle(
              color: Color(0xFF20A0D8), fontWeight: FontWeight.bold),
        ),
    ],
  );
}


  Widget buildServicesTab() {
    return  Center(
      child: Text(
        "List of services will appear here.",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget buildReviewsTab() {
    return  Center(
      child: Text(
        "User reviews will appear here.",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
  

}

