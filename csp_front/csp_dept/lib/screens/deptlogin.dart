import 'package:flutter/material.dart';

// ignore: camel_case_types
class deptlogin extends StatelessWidget {
  const deptlogin({super.key});
// backgroundColor: const Color.fromARGB(255, 106, 233, 110),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          title: const Center(
            child: Text(
              "WELCOME TO CSP",
              style: TextStyle(
                  color: Color.fromARGB(179, 253, 251, 251), fontSize: 25),
            ),
          ),
          backgroundColor: Colors.green,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                    height: 100,
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "DEPARTMENT ID",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 158, 158, 158))),
                      obscureText: false,
                    )),
                const SizedBox(height: 20),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "PASSWORD",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 158, 158, 158))),
                      obscureText: false,
                    )),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text('Log in')),
                ),
              ],
            ),
          ),
        ));
  }
}
