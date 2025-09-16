import 'package:flutter/material.dart';
import 'package:medilink/constant/appcolor.dart';

class DocWorkingHours extends StatefulWidget {
  const DocWorkingHours({super.key});

  @override
  State<DocWorkingHours> createState() => _DocWorkingHoursState();
}

class _DocWorkingHoursState extends State<DocWorkingHours> {
  final List<String> days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  final List<String> times = [
    "6 AM",
    "7 AM",
    "8 AM",
    "9 AM",
    "10 AM",
    "11 AM",
    "12 PM",
    "1 PM",
    "2 PM",
    "3 PM",
    "4 PM",
    "5 PM",
    "6 PM",
    "7 PM",
    "8 PM",
    "9 PM",
    "10 PM",
  ];

  Set<String> selectedDays = {}; // track selected days
  Map<String, String> startTimes = {}; // track start times per day
  Map<String, String> endTimes = {}; // track end times per day

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColor.background),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),

            /// -------------------------------
            /// DON'T TOUCH THIS PART (circle avatar)
            /// -------------------------------
            Stack(
              children: [
                Center(
                  child: Container(
                    width: 180,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColor.gradientColor,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Image(
                        image: AssetImage("assets/images/doc 1.png"),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  top: 70,
                  left: 200,
                  child: SizedBox(
                    height: 22,
                    width: 22,
                    child: Image(
                      image: AssetImage("assets/images/Add Camera.png"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              "Doctor",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'poppins',
                color: Color(AppColor.primary),
              ),
            ),
            const SizedBox(height: 20),

            /// -------------------------------
            /// WORKING HOURS CARD
            /// -------------------------------
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Working Hours",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF106B96),
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// Available days
                    const Text(
                      "Available Days",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(AppColor.primary),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: List.generate(days.length, (index) {
                        final day = days[index];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: selectedDays.contains(day),
                              onChanged: (val) {
                                setState(() {
                                  if (val == true) {
                                    selectedDays.add(day);
                                    // give defaults if not already set
                                    startTimes.putIfAbsent(
                                      day,
                                      () => times.first,
                                    );
                                    endTimes.putIfAbsent(day, () => times.last);
                                  } else {
                                    selectedDays.remove(day);
                                    startTimes.remove(day);
                                    endTimes.remove(day);
                                  }
                                });
                              },
                              activeColor: Color(AppColor.primary),
                              side: BorderSide(color: Color(AppColor.primary)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            Text(
                              day,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(AppColor.primary),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),

                    const Divider(height: 32),

                    /// Available time slots
                    const Text(
                      "Available Time Slots",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF106B96),
                      ),
                    ),
                    const SizedBox(height: 8),

                    selectedDays.isEmpty
                        ? const Text(
                            "Select days to set available time slots",
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: selectedDays.length,
                            itemBuilder: (context, index) {
                              final day = selectedDays.elementAt(index);
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      day,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(AppColor.primary),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        // Start time
                                        Container(
                                          height: 25,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(AppColor.primary),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: DropdownButton<String>(
                                              underline: const SizedBox(),
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Color(AppColor.primary),
                                                size: 20,
                                              ),
                                              style: TextStyle(
                                                color: Color(AppColor.primary),
                                                fontSize: 10,
                                              ),
                                              isExpanded: true,
                                              value: startTimes[day],
                                              items: times
                                                  .map(
                                                    (t) => DropdownMenuItem(
                                                      value: t,
                                                      child: Text(t),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (val) {
                                                setState(() {
                                                  startTimes[day] = val!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                        // End time
                                        Container(
                                          height: 25,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(AppColor.primary),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: DropdownButton<String>(
                                              underline: const SizedBox(),
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Color(AppColor.primary),
                                                size: 20,
                                              ),
                                              style: TextStyle(
                                                color: Color(AppColor.primary),
                                                fontSize: 10,
                                              ),
                                              isExpanded: true,
                                              value: endTimes[day],
                                              items: times
                                                  .map(
                                                    (t) => DropdownMenuItem(
                                                      value: t,
                                                      child: Text(t),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (val) {
                                                setState(() {
                                                  endTimes[day] = val!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                    const SizedBox(height: 20),

                    /// Continue button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(AppColor.primary),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          print("Selected Days: $selectedDays");
                          print("Start Times: $startTimes");
                          print("End Times: $endTimes");
                        },
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            color: Color(AppColor.textSecondary),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Back",
                          style: TextStyle(color: Color(AppColor.primary)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
