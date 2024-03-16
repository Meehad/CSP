// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'package:csp_citizen/models/user_data.dart';
import 'package:csp_citizen/screens/otp_page.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController adId = TextEditingController();
    void login(Id) async {
      try {
        Response response =
            await post(loginurl, body: {'id_number': Id.toString()});
        if (response.statusCode == 200) {
          Map<String, dynamic> responseMap = jsonDecode(response.body);
          var otp = responseMap['otp'].toString();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => OtpPage(otp: otp)));
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.grey[300],
                  title: const Text('CSP'),
                  content: const Text('Failed!'),
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
        print(e.toString());
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "CENTRAL SERVICE PORTAL",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30),
            ).animate().fadeIn(delay: 1700.ms).scaleY(),
            const Padding(
              padding: EdgeInsets.all(40.0),
              child: Image(
                image: AssetImage('assets/logo.png'),
                height: 200,
              ),
            ),

            // Hello again

            const Text(
              "WELCOME",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25),
            ).animate().fadeIn(delay: 2200.ms).scaleY(),
            // adhaar textfeild
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: adId,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
                  ],
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20.0)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      fillColor: const Color.fromRGBO(255, 255, 255, 1),
                      filled: true,
                      hintText: "AADHAAR NO",
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 158, 158, 158))),
                  obscureText: false,
                ).animate().fadeIn(delay: 2500.ms).scaleY()),
            const SizedBox(height: 20),
            // buttonar

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize:
                    const Size(140, 40), //button dimentions for login button
                foregroundColor: const Color(0xFF698996),
                backgroundColor: const Color.fromARGB(255, 213, 213, 213),
                elevation: 5, // elevation
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                    // rounded corners
                    ),
              ),
              onPressed: () {
                login(adId.text);
                context.read<DataClass>().changeId(new_id_num: adId.text);
              },
              child: const Text(
                'SEND OTP',
                style: TextStyle(fontSize: 15),
              ),
            ).animate().fadeIn(delay: 2900.ms).scaleY(),
          ],
        )),
      ),
    );
  }
}
