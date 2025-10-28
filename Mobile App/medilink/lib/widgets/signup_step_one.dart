import 'package:flutter/material.dart';
import 'package:medilink/widgets/custom_textfield.dart';

class SignUpStepOne extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController genderController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController emergencyNameController;
  final TextEditingController relationshipController;
  final TextEditingController emergencyPhoneController;
  final VoidCallback onContinue;
  final VoidCallback onBack;

  const SignUpStepOne({
    super.key,
    required this.nameController,
    required this.ageController,
    required this.genderController,
    required this.phoneController,
    required this.addressController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.emergencyNameController,
    required this.relationshipController,
    required this.emergencyPhoneController,
    required this.onContinue,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          const _SectionTitle("Personal Information"),
          const SizedBox(height: 5),
          CustomTextField(
            label: "Name",
            hint: "Enter Your Name",
            controller: nameController,
          ),
          CustomTextField(
            label: "Age",
            hint: "Enter Your Age",
            controller: ageController,
          ),
          CustomTextField(
            label: "Gender",
            hint: "Select Your Gender",
            controller: genderController,
          ),
          CustomTextField(
            label: "Phone",
            hint: "Enter Your Phone",
            controller: phoneController,
          ),
          CustomTextField(
            label: "Address",
            hint: "Enter Your Full Address",
            controller: addressController,
          ),
          CustomTextField(
            label: "Email",
            hint: "Enter Your Email",
            controller: emailController,
          ),
          CustomTextField(
            label: "Password",
            hint: "At Least 6 Character",
            controller: passwordController,
            isPassword: true,
          ),
          CustomTextField(
            label: "Confirm Password",
            hint: "Confirm Your Password",
            controller: confirmPasswordController,
            isPassword: true,
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.grey[400]),
          const SizedBox(height: 20),
          const _SectionTitle("Emergency Contact Info"),
          const SizedBox(height: 10),
          CustomTextField(
            label: "Name",
            hint: "Enter Contact Name",
            controller: emergencyNameController,
          ),
          CustomTextField(
            label: "Relationship",
            hint: "Eg: Mum",
            controller: relationshipController,
          ),
          CustomTextField(
            label: "Phone Number",
            hint: "Enter Contact Phone",
            controller: emergencyPhoneController,
          ),

          const SizedBox(height: 25),

          // Buttons
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff00AEEF),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: onContinue,
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: onBack,
                child: const Text(
                  "Back",
                  style: TextStyle(
                    color: Color(0xff00AEEF),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xff0078B7),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
