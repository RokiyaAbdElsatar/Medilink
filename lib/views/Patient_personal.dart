import 'package:flutter/material.dart';
import 'package:medilink/services/auth_services.dart';
import 'package:medilink/views/login_screen.dart';
import 'package:medilink/widgets/progress_bar.dart';
import 'package:medilink/widgets/signup_step_one.dart';
import 'package:medilink/widgets/signup_step_two.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int currentStep = 0;
  bool isLoading = false;

  // Controllers
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emergencyNameController = TextEditingController();
  final relationshipController = TextEditingController();
  final emergencyPhoneController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final bloodTypeController = TextEditingController();
  final chronicController = TextEditingController();
  final allergiesController = TextEditingController();
  final medicationsController = TextEditingController();
  final historyController = TextEditingController();
  final doctorNameController = TextEditingController();
  final doctorPhoneController = TextEditingController();

  void nextStep() => setState(() => currentStep++);
  void prevStep() => setState(() => currentStep--);

  Future<void> handleSignUp() async {
    // Basic validation
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields")),
      );
      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    setState(() => isLoading = true);

    // Prepare data
    final userData = {
      'name': nameController.text.trim(),
      'age': ageController.text.trim(),
      'gender': genderController.text.trim(),
      'phone': phoneController.text.trim(),
      'address': addressController.text.trim(),
      'email': emailController.text.trim(),
      'emergencyContact': {
        'name': emergencyNameController.text.trim(),
        'relationship': relationshipController.text.trim(),
        'phone': emergencyPhoneController.text.trim(),
      },
      'medicalInfo': {
        'height': heightController.text.trim(),
        'weight': weightController.text.trim(),
        'bloodType': bloodTypeController.text.trim(),
        'chronicConditions': chronicController.text.trim(),
        'allergies': allergiesController.text.trim(),
        'medications': medicationsController.text.trim(),
        'history': historyController.text.trim(),
        'doctorName': doctorNameController.text.trim(),
        'doctorPhone': doctorPhoneController.text.trim(),
      },
    };

    final authService = AuthService();
    final error = await authService.registerUser(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      userData: userData,
    );

    setState(() => isLoading = false);

    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    } else {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00AEEF),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Sign Up",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Progress Bar
            ProgressBar(currentStep: currentStep),
            const SizedBox(height: 20),

            // Step Container
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Stack(
                  children: [
                    IndexedStack(
                      index: currentStep,
                      children: [
                        SignUpStepOne(
                          nameController: nameController,
                          ageController: ageController,
                          genderController: genderController,
                          phoneController: phoneController,
                          addressController: addressController,
                          onContinue: nextStep,
                          emailController: emailController,
                          passwordController: passwordController,
                          confirmPasswordController: confirmPasswordController,
                          emergencyNameController: emergencyNameController,
                          relationshipController: relationshipController,
                          emergencyPhoneController: emergencyPhoneController,
                          onBack: () {},
                        ),
                        MedicalInformationStep(
                          heightController: heightController,
                          weightController: weightController,
                          bloodTypeController: bloodTypeController,
                          chronicController: chronicController,
                          allergiesController: allergiesController,
                          medicationsController: medicationsController,
                          historyController: historyController,
                          doctorNameController: doctorNameController,
                          doctorPhoneController: doctorPhoneController,
                          onBack: prevStep,
                          onContinue: handleSignUp, // 👈 calls Firebase
                        ),
                      ],
                    ),

                    // Loading overlay
                    if (isLoading)
                      Container(
                        color: Colors.white70,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff00AEEF),
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
