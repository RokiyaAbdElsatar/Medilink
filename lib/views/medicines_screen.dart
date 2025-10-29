
import 'package:flutter/material.dart';

class MedicinesScreen extends StatelessWidget {
  const MedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicines'),
      ),
      body: const Center(
        child: Text('Medicines Screen Content'),
      ),
    );
  }
}