// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:csp_citizen/models/user_data.dart';
import 'package:csp_citizen/screens/otp_page.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
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
    void login(String Id) async {
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
      backgroundColor:Color(0xFFC9C5BA),
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "CITIZEN SERVICE PORTAL",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30),
            ),
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
            ),
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
                )),
            SizedBox(height: 20),
            // buttonar

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize:
                    const Size(140, 40), //button dimentions for login button
                primary: Color(0xFF97B1A6), // background color
                onPrimary: Colors.white, // text color
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
            ),
          ],
        )),
      ),
    );
  }
}
