import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/views/login_screen.dart';
import 'package:medilink/widgets/emergency_contact_container.dart';
import 'package:medilink/widgets/medical_info_container.dart';
import 'package:medilink/widgets/personal_info_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image');
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _imageFile = File(imagePath);
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final file = File(picked.path);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', file.path);
      setState(() {
        _imageFile = file;
      });
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('patients')
        .doc(user.uid)
        .get();

    if (!doc.exists) return null;
    return doc.data();
  }

  void refresh() => setState(() {});

  // ------------------ دوال التعديل ------------------ //
  Future<void> _editPersonalInfo(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docRef = FirebaseFirestore.instance.collection('patients').doc(user.uid);
    final data = (await docRef.get()).data() ?? {};

    final emailController = TextEditingController(text: data['email'] ?? '');
    final phoneController = TextEditingController(text: data['phone'] ?? '');
    final addressController = TextEditingController(text: data['address'] ?? '');
    final languageController = TextEditingController(text: data['language'] ?? '');

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Personal Info"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
              TextField(controller: phoneController, decoration: const InputDecoration(labelText: "Phone")),
              TextField(controller: addressController, decoration: const InputDecoration(labelText: "Address")),
              TextField(controller: languageController, decoration: const InputDecoration(labelText: "Language")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () async {
              await docRef.update({
                'email': emailController.text,
                'phone': phoneController.text,
                'address': addressController.text,
                'language': languageController.text,
              });
              Navigator.pop(context);
              refresh();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Future<void> _editMedicalInfo(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docRef = FirebaseFirestore.instance.collection('patients').doc(user.uid);
    final data = (await docRef.get()).data() ?? {};
    final medicalInfo = data['medicalInfo'] ?? {};

    final bloodController = TextEditingController(text: medicalInfo['bloodType'] ?? '');
    final chronicController = TextEditingController(text: medicalInfo['chronicConditions'] ?? '');
    final medsController = TextEditingController(text: medicalInfo['medications'] ?? '');
    final allergiesController = TextEditingController(text: medicalInfo['allergies'] ?? '');
    final historyController = TextEditingController(text: medicalInfo['history'] ?? '');

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Medical Info"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: bloodController, decoration: const InputDecoration(labelText: "Blood Type")),
              TextField(controller: chronicController, decoration: const InputDecoration(labelText: "Chronic Conditions")),
              TextField(controller: medsController, decoration: const InputDecoration(labelText: "Medications")),
              TextField(controller: allergiesController, decoration: const InputDecoration(labelText: "Allergies")),
              TextField(controller: historyController, decoration: const InputDecoration(labelText: "Medical History")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () async {
              await docRef.update({
                'medicalInfo': {
                  'bloodType': bloodController.text,
                  'chronicConditions': chronicController.text,
                  'medications': medsController.text,
                  'allergies': allergiesController.text,
                  'history': historyController.text,
                },
              });
              Navigator.pop(context);
              refresh();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Future<void> _editEmergencyContact(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docRef = FirebaseFirestore.instance.collection('patients').doc(user.uid);
    final data = (await docRef.get()).data() ?? {};
    final emergencyContact = data['emergencyContact'] ?? {};

    final nameController = TextEditingController(text: emergencyContact['name'] ?? '');
    final phoneController = TextEditingController(text: emergencyContact['phone'] ?? '');
    final relationController = TextEditingController(text: emergencyContact['relationship'] ?? '');

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Emergency Contact"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: phoneController, decoration: const InputDecoration(labelText: "Phone")),
            TextField(controller: relationController, decoration: const InputDecoration(labelText: "Relationship")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () async {
              await docRef.update({
                'emergencyContact': {
                  'name': nameController.text,
                  'phone': phoneController.text,
                  'relationship': relationController.text,
                },
              });
              Navigator.pop(context);
              refresh();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // ---------------- واجهة المستخدم ---------------- //
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No profile data found."));
          }

          final userData = snapshot.data!;
          final medicalInfo = userData['medicalInfo'] ?? {};
          final emergency = userData['emergencyContact'] ?? {};

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.07),

                    // ✅ Background arc shape
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -height * 0.29,
                          right: -width * 0.09,
                          child: Container(
                            width: width * 1.3,
                            height: height * 0.45,
                            decoration: const BoxDecoration(
                              color: Color(AppColor.background),
                              borderRadius: BorderRadius.all(Radius.elliptical(600, 400)),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: _pickImage,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage: _imageFile != null
                                        ? FileImage(_imageFile!)
                                        : (userData['profileImage'] != null
                                            ? NetworkImage(userData['profileImage'])
                                            : const AssetImage('assets/images/EllipseP.png')) as ImageProvider,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(AppColor.primary),
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(userData['name'] ?? "Unknown User", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                                      Text("${userData['age'] ?? ''} / ${userData['gender'] ?? ''}", style: const TextStyle(color: Colors.grey, fontSize: 16), overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                                      (route) => false,
                                    );
                                  },
                                  icon: const Icon(Icons.logout, color: Color(AppColor.primary)),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // ✅ User info containers
                    PersonalInfoContainer(
                      email: userData['email'] ?? '',
                      phone: userData['phone'] ?? '',
                      address: userData['address'] ?? '',
                      language: userData['language'] ?? '',
                      onEdit: () => _editPersonalInfo(context),
                    ),
                    const SizedBox(height: 15),
                    MedicalInfoContainer(
                      bloodType: medicalInfo['bloodType'] ?? '',
                      chronicCondition: medicalInfo['chronicConditions'] ?? '',
                      currentMedications: medicalInfo['medications'] ?? '',
                      allergies: medicalInfo['allergies'] ?? '',
                      medHistory: medicalInfo['history'] ?? '',
                      onEdit: () => _editMedicalInfo(context),
                    ),
                    const SizedBox(height: 15),
                    EmergencyContactContainer(
                      name: emergency['name'],
                      phone: emergency['phone'] ?? '',
                      relationShip: emergency['relationship'],
                      onEdit: () => _editEmergencyContact(context),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
