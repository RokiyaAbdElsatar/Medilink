import 'package:flutter/material.dart';
import 'package:medilink/widgets/custom_textfield.dart';

class MedicalInformationStep extends StatelessWidget {
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController bloodTypeController;
  final TextEditingController chronicController;
  final TextEditingController allergiesController;
  final TextEditingController medicationsController;
  final TextEditingController historyController;
  final TextEditingController doctorNameController;
  final TextEditingController doctorPhoneController;
  final VoidCallback onContinue;
  final VoidCallback onBack;

  const MedicalInformationStep({
    super.key,
    required this.heightController,
    required this.weightController,
    required this.bloodTypeController,
    required this.chronicController,
    required this.allergiesController,
    required this.medicationsController,
    required this.historyController,
    required this.doctorNameController,
    required this.doctorPhoneController,
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
          const _SectionTitle("Medical Information"),
          const SizedBox(height: 5),

          CustomTextField(
            label: "Height",
            hint: "Enter Your Height",
            controller: heightController,
          ),
          CustomTextField(
            label: "Weight",
            hint: "Enter Your Weight",
            controller: weightController,
          ),
          _BloodTypeDropdown(controller: bloodTypeController),
          CustomTextField(
            label: "Chronic Conditions",
            hint: "Enter Your Chronic Conditions",
            controller: chronicController,
          ),
          CustomTextField(
            label: "Allergies",
            hint: "Enter Your Allergies",
            controller: allergiesController,
          ),
          CustomTextField(
            label: "Current Medications",
            hint: "Enter Your Current Medications",
            controller: medicationsController,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Medical History Summary",
                style: TextStyle(
                  color: Color(0xff0078B7),
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: historyController,
                minLines: 4,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Enter Your Medical History",
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff00AEEF),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff00AEEF),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
              ),
            ],
          ),
          CustomTextField(
            label: "Your Primary Doctor",
            hint: "Enter Your Doctor Name",
            controller: doctorNameController,
          ),
          CustomTextField(
            label: "Doctor Phone",
            hint: "Enter Your Doctor Phone",
            controller: doctorPhoneController,
          ),

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

class _BloodTypeDropdown extends StatefulWidget {
  final TextEditingController controller;
  const _BloodTypeDropdown({required this.controller});

  @override
  State<_BloodTypeDropdown> createState() => _BloodTypeDropdownState();
}

class _BloodTypeDropdownState extends State<_BloodTypeDropdown> {
  final List<String> bloodTypes = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
  ];
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedType,
      decoration: InputDecoration(
        labelText: "Blood Type",
        hintText: "Select Your Blood Type",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
      items: bloodTypes
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
      onChanged: (value) {
        setState(() => selectedType = value);
        widget.controller.text = value ?? "";
      },
    );
  }
}
