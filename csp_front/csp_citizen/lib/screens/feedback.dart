// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class feedback extends StatefulWidget {
  const feedback({super.key});

  @override
  State<feedback> createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSP'),
      ),
      body: Center(
          child: Column(
        children: [
          Card(
            elevation: 20,
            color: Colors.orangeAccent,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  const Text('This is flutter card'),
                  TextButton(onPressed: () {}, child: const Text('press')),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
