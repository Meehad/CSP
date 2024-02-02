// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:csp_citizen/screens/otp_page.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

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
                    MaterialButton(onPressed: () {
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
      backgroundColor: Colors.green,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("CITIZEN SERVICE PORTAL",
            style: 
            TextStyle(
                  color: Color.fromARGB(179, 253, 251, 251), fontSize: 25),),
            const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                    height: 200,
                  ),
                ),
            
            // Hello again
            
            const Text("WELCOME",
            style: TextStyle(
                  color: Color.fromARGB(179, 253, 251, 251), fontSize: 20),),
            // adhaar textfeild
            TextField(
              controller: adId,
              decoration: const InputDecoration(label: Text('Adhaar ID') ,
              contentPadding: EdgeInsets.symmetric(horizontal:(20.0)) //text field label hint alignment(Adhaar ID)
              ),
            ),
            // buttonar
            
                ElevatedButton(
                       style: ElevatedButton.styleFrom(
                        fixedSize: const Size(140, 40),//button dimentions for login button
                               primary: Colors.white, // background color
                            onPrimary: Colors.green, // text color
                             elevation: 5, // elevation
                         shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                             // rounded corners
                              ),
                                    ),
                               onPressed: () {
                              login(adId.text);
                             },
                               child: const Text('LOGIN',style: TextStyle(fontSize: 20),),
                             ),
          ],
        )
        ),
      ),
    );
  }
}
