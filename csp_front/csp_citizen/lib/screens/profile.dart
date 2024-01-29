// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSP'),
      ),
      body: const Center(
        child: Column(
          children: [
            CircleAvatar(
                radius: 35.0,
                backgroundImage: AssetImage('assets/images/greg.png')),
            Text('Greg'),
            Text('12/05/2002'),
            Text('Address'),
          ],
        ),
      ),
    );
  }
}
