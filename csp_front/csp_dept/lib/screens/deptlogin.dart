import 'package:csp_dept/models/dept_data.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class DeptLogin extends StatelessWidget {
  const DeptLogin({Key? key}) : super(key: key);

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
        ),
        // backgroundColor: Colors.teal[400],
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
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: dpId,
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
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: dppwd,
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
                ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
