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
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hello again
            const Text("Welcome"),
            // adhaar textfeild
            TextField(
              controller: adId,
              decoration: const InputDecoration(label: Text('Adhaar ID')),
            ),
            // button
            ElevatedButton(
                onPressed: () {
                  login(adId.text);
                },
                child: const Text('Log in')),
          ],
        ),
      )),
    );
  }
}
