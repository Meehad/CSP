import 'package:csp_dept/screens/deptlogin.dart';
import 'package:flutter/material.dart';

class Department {
  final int id;
  final String name;
  final String head;
  final String imagePath;

  Department(this.id, this.name, this.head, this.imagePath);
}

// ignore: camel_case_types
class deptdetails extends StatelessWidget {
   deptdetails({Key? key}) : super(key: key);

  final List<Department> departments = [
    Department(1, 'KSEB', 'Dr. Rajan N. Khobragade', 'assets/kseblogo.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(146, 245, 142, 1),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 40.0),
          child: Center(
            child: Text(
              'DEPARTMENT DETAILS',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 140.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...departments.map((department) {
                return _buildRectangle(department);
              }).toList(),
              const SizedBox(height: 70.0), // Add spacing
              // Logout IconButton
              IconButton(
                onPressed: ()
                {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const DeptLogin()));
                }, // Set onPressed to null for no functionality
                icon: const Icon(Icons.logout, color: Colors.black, size: 50.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRectangle(Department department) {
    return Container(
      width: 300.0,
      height: 150.0,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Profile Picture
          CircleAvatar(
            backgroundImage: AssetImage(department.imagePath),
            radius: 30.0,
          ),
          // Department Information
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${department.id}'),
              Text('Name: ${department.name}'),
              Text('Head: ${department.head}'),
            ],
          ),
        ],
      ),
    );
  }
}
