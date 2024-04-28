// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:csp_dept/models/dept_data.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class DeptLogin extends StatelessWidget {
  const DeptLogin({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController dpId = TextEditingController();
    TextEditingController dppwd = TextEditingController();
    void login(String Id, String pwd) async {
      try {
        Response response = await post(loginurl,
            body: {'dept_id': Id.toString(), 'dpassword': pwd.toString()});
        if (response.statusCode == 200) {
          Navigator.pushNamed(context, '/home');
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.grey[300],
                  title: const Text('CSP'),
                  content: const Text('Failed to Login'),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('ok'),
                    )
                  ],
                );
              });
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }

    return Scaffold(
      // backgroundColor: Colors.teal[400],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "WELCOME TO CSP",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ).animate().fadeIn(delay: 500.ms).scaleY(),
        backgroundColor: const Color(0xFF698996),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'assets/logo.png',
                  height: 165,
                ).animate().fadeIn(delay: 800.ms).scaleY(),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: dpId,
                  style: const TextStyle(color: Color(0xFF698996)),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "DEPARTMENT ID",
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ).animate().fadeIn(delay: 1100.ms).scaleY(),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: dppwd,
                  style: const TextStyle(color: Color(0xFF698996)),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "PASSWORD",
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  obscureText: true,
                ).animate().fadeIn(delay: 1400.ms).scaleY(),
              ),
              const SizedBox(height: 7),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(140, 40),
                  // primary: Colors.white,
                  // onPrimary: Colors.teal[900],
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  login(dpId.text, dppwd.text);
                  context.read<DeptDataClass>().changeId(new_id_num: dpId.text);
                },
                child: const Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 20),
                ),
              ).animate().fadeIn(delay: 1700.ms).scaleY(),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF698996),
    );
  }
}
