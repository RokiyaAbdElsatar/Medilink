import 'package:flutter/material.dart';
import 'package:medilink/constant/appcolor.dart';
import 'package:medilink/views/Pharmacies.dart';
import 'package:medilink/views/home_screen.dart';
import 'package:medilink/widgets/textfield.dart';

class PatientPersonal extends StatefulWidget {
  const PatientPersonal({super.key});

  @override
  State<PatientPersonal> createState() => _PatientPersonal();
}

GlobalKey<FormState> formkey = GlobalKey();

class _PatientPersonal extends State<PatientPersonal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF20A0D8), // اللون الأزرق العلوي
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text(
              "Sign Up",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // الفورم الأبيض
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF20A0D8),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Textfield(labletitle: "Name", hinttitle: "Enter Your Name"),
                    const SizedBox(height: 15),
                    Textfield(labletitle: "Age", hinttitle: "Enter Your Age"),
                    const SizedBox(height: 15),
                    Textfield(
                      labletitle: "Gender",
                      hinttitle: "Select Your Gender",
                    ),
                    const SizedBox(height: 15),
                    Textfield(
                      labletitle: "Phone",
                      hinttitle: "Enter Your Phone",
                    ),
                    const SizedBox(height: 15),
                    Textfield(
                      labletitle: "Address",
                      hinttitle: "Enter Your Full Address",
                    ),
                    const SizedBox(height: 15),
                    Textfield(
                      labletitle: "Email",
                      hinttitle: "Enter Your Email",
                    ),
                    const SizedBox(height: 15),
                    Textfield(
                      labletitle: "Password",
                      hinttitle: "At Least 6 Character",
                    ),
                    const SizedBox(height: 15),
                    Textfield(
                      labletitle: "Confirm Password",
                      hinttitle: "Re-enter Your Password",
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF20A0D8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF20A0D8)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            color: Color(0xFF20A0D8),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
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
