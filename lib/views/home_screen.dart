// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medilink/constant/appcolor.dart';
import 'package:medilink/views/drawer_screen.dart';
import 'package:medilink/widgets/pharmacy_container.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<String> urls = [
    "https://play-lh.googleusercontent.com/3Ayv-0-hV6MnV6EPq21gqo5ffL-2dplZUh7X797G1PLQcwnINF6vUQbWmxTKl-jMYFw",
    "https://m.edarabia.com/wp-content/uploads/2020/04/elezaby-pharmacy-cairo-egypt.jpg",
  ];
  List<String> mainTexts = ["Misr Pharamcies", "El Ezaby Pharmacies"];
  List<String> subTexts = ["200+ Branches", "330+ Branches"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerScreen(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -200,
                  right: -20,
                  child: Container(
                    width: 500,
                    height: 400,
                    decoration: const BoxDecoration(
                      color: Color(AppColor.backGroundColor),
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(600, 400),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50.0,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Builder(
                            builder: (context) => CircleAvatar(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                icon: const Icon(Icons.menu),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.notifications_outlined),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text("Hello,", style: TextStyle(fontSize: 24)),
                      const Text(
                        "James Anderson",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),

            Container(
              height: 120,
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(AppColor.primary),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/Vector.png"),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Aspirin",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "One daily",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "100 mg",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 60),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(AppColor.doneChoose),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  "Mark as taken",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 21),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: Color(AppColor.primary),
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Wed, 10 Sep 2025",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.access_time,
                                    color: Color(AppColor.primary),
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "10:00 - 10:30 AM",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Suggested Pharmacies",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF106B96),
                    ),
                  ),
                  Row(
                    children: [
                      Text("See All", style: TextStyle(fontSize: 10)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_sharp, size: 12),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 6,
                  childAspectRatio: 0.86,
                ),
                itemCount: 2,
                itemBuilder: (context, index) => PharmacyContainer(
                  imgUrl: urls[index],
                  mainText: mainTexts[index],
                  subText: subTexts[index],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
