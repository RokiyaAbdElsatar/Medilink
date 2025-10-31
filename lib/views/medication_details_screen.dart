import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/models/medication_model.dart';
import 'package:medilink/services/medication_services.dart';
import 'package:medilink/views/add_edit_medication_screen.dart';
import 'package:medilink/widgets/action_buttons.dart';
import 'package:medilink/widgets/custom_app_bar.dart';
import 'package:medilink/widgets/details_section.dart';
import 'package:medilink/widgets/medicine_header.dart';
import 'package:medilink/widgets/schedule_section.dart';

class MedicationDetailsScreen extends StatefulWidget {
  final Medication medication;

  const MedicationDetailsScreen({super.key, required this.medication});

  @override
  State<MedicationDetailsScreen> createState() =>
      _MedicationDetailsScreenState();
}

class _MedicationDetailsScreenState extends State<MedicationDetailsScreen> {
  late Medication _currentMedication;
  final _medService = MedicationService();
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _currentMedication = widget.medication;
  }

  Future<void> _navigateToEdit() async {
    final updatedMed = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddEditMedicationScreen(existingMedication: _currentMedication),
      ),
    );

    if (updatedMed != null && mounted) {
      setState(() {
        _currentMedication = updatedMed;
      });
    }
  }

  Future<void> _confirmDelete() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Medication'),
        content: const Text(
          'Are you sure you want to delete this medication? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      await _deleteMedication();
    }
  }

  Future<void> _deleteMedication() async {
    setState(() => _isDeleting = true);
    try {
      await _medService.deleteMedication(_currentMedication.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Medication deleted successfully.')),
        );
        Navigator.pop(context); // 👈 go back after deletion
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting medication: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Medication Details',
        icon: Icons.mode_edit,
        onPressed: _navigateToEdit,
        shape: BoxShape.rectangle,
      ),
      backgroundColor: const Color(AppColor.textSecondary),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MedicineHeader(
                initialName: _currentMedication.name,
                initialDosage: _currentMedication.dosage,
              ),
              const SizedBox(height: 20),
              DetailsSection(
                frequency: _currentMedication.frequency,
                time: _currentMedication.timeCategory,
                startDate: _currentMedication.time,
              ),
              const SizedBox(height: 20),
              ScheduleSection(selectedDays: _currentMedication.days),
              const SizedBox(height: 20),
              ActionButtons(
                onDelete: _isDeleting ? null : _confirmDelete,
                onMarkAsTaken: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
