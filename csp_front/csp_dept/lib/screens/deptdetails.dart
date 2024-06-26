// ignore_for_file: camel_case_types

import 'package:csp_dept/models/dept_data.dart';
import 'package:csp_dept/screens/deptlogin.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class deptdetails extends StatefulWidget {
  const deptdetails({super.key});

  @override
  State<deptdetails> createState() => _deptdetailsState();
}

class _deptdetailsState extends State<deptdetails> {
  @override
  void initState() {
    super.initState();
    // Don't perform context-dependent operations here
    // Move it to build() or didChangeDependencies()
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DeptDataClass>(context);
    final String img = postModel.post?.image ?? "";
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 40.0),
          child: Center(
            child: Text(
              'DEPARTMENT DETAILS',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 70.0, top: 70.0),
              child: Container(
                width: 300.0,
                height: 280.0,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 190, 190, 190)
                            .withOpacity(1),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: const Offset(0, 0),
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70.0,
                      backgroundImage: NetworkImage(imageU(img)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      postModel.post?.name ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Head',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 43, 43, 43)),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          postModel.post?.head ?? "",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 43, 43, 43)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Department ID:',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 40, 40, 40)),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          postModel.post?.dept_id ?? "",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 40, 40, 40)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 160),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.lightBlueAccent,
                backgroundColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const DeptLogin()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout,
                  color: Color.fromARGB(255, 44, 44, 44)),
              label: const Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                child: Text('LOGOUT',
                    style: TextStyle(fontSize: 20, color: Colors.teal)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
