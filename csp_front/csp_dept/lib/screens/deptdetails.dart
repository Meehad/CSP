import 'package:flutter/material.dart';

class deptdetails extends StatelessWidget {
  const deptdetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 120, 245, 124),
      appBar: AppBar(
        title:  const Padding(
          padding: EdgeInsets.only(right: 40.0),
          child: Center(
            child: Text(
              'DEPARTMENT DETAILS',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
        ),
    ));
  }
}