import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/widgets/custom_textfield.dart';

class SignUpStepOne extends StatefulWidget {
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
  State<SignUpStepOne> createState() => _SignUpStepOneState();
}

class _SignUpStepOneState extends State<SignUpStepOne> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle("Personal Information"),
          CustomTextField(
            label: "Name",
            hint: "Enter Your Name",
            controller: widget.nameController,
          ),
          CustomTextField(
            label: "Age",
            hint: "Enter Your Age",
            controller: widget.ageController,
            keyboardType: TextInputType.number,
          ),
          DropdownButtonFormField<String>(
            dropdownColor: Color(AppColor.background),
            value: selectedGender,
            decoration: const InputDecoration(
              labelText: "Gender",
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: "Male", child: Text("Male")),
              DropdownMenuItem(
                value: "Female",
                child: Text("Female", selectionColor: Color(AppColor.primary)),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedGender = value;
                widget.genderController.text = value!;
              });
            },
          ),
          const SizedBox(height: 10),
          CustomTextField(
            label: "Phone",
            hint: "Enter Your Phone",
            controller: widget.phoneController,
            keyboardType: TextInputType.phone,
          ),
          CustomTextField(
            label: "Address",
            hint: "Enter Your Address",
            controller: widget.addressController,
          ),
          CustomTextField(
            label: "Email",
            hint: "Enter Your Email",
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomTextField(
            label: "Password",
            hint: "At least 6 characters",
            controller: widget.passwordController,
            isPassword: true,
          ),
          CustomTextField(
            label: "Confirm Password",
            hint: "Confirm Password",
            controller: widget.confirmPasswordController,
            isPassword: true,
          ),
          const SizedBox(height: 20),
          const _SectionTitle("Emergency Contact Info"),
          CustomTextField(
            label: "Name",
            hint: "Contact Name",
            controller: widget.emergencyNameController,
          ),
          CustomTextField(
            label: "Relationship",
            hint: "e.g. Mom, Brother",
            controller: widget.relationshipController,
          ),
          CustomTextField(
            label: "Phone Number",
            hint: "Enter Contact Phone",
            controller: widget.emergencyPhoneController,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff00AEEF),
                ),
                onPressed: widget.onContinue,
                child: const Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: widget.onBack,
                child: const Text(
                  "Back",
                  style: TextStyle(color: Color(0xff00AEEF), fontSize: 15),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xff0078B7),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
