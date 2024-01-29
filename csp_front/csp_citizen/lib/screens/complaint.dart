// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class complaint extends StatefulWidget {
  const complaint({super.key});

  @override
  State<complaint> createState() => _complaintState();
}

class _complaintState extends State<complaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSP'),
      ),
      body: Center(
        child: Column(
          children: [
            const TextField(),
            const SizedBox(height: 10),
            const TextField(),
            const SizedBox(height: 10),
            const Icon(Icons.camera),
            const SizedBox(height: 10),
            const Icon(Icons.place),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text('Submit'))
          ],
        ),
      ),
    );
  }
}
