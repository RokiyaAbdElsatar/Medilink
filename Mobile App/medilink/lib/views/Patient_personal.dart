import 'package:flutter/material.dart';
import 'package:medilink/views/home_screen.dart';
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

            // Steps Container
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: IndexedStack(
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
                 
                      onContinue: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
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
