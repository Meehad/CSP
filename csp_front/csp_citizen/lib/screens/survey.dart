// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class survey extends StatefulWidget {
  const survey({super.key});

  @override
  State<survey> createState() => _surveyState();
}

class _surveyState extends State<survey> {
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
                  const Text('Questions'),
                  const TextField(),
                  TextButton(onPressed: () {}, child: const Text('press')),
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
