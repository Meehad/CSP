import 'package:csp_dept/screens/depthome.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class deptlogin extends StatelessWidget {
  const deptlogin({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          title: const Center(
            child: Text(
              "WELCOME TO CSP",
              style: TextStyle(
                  color: Color.fromARGB(179, 253, 251, 251), fontSize: 30),
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
                    height: 175,
                  ),
                ),
                const SizedBox(height: 45,),
                 Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      decoration: InputDecoration(
                          enabledBorder:  OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20.0)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                              ),
                          fillColor: const Color.fromRGBO(255, 255, 255, 1),
                          filled: true,
                          hintText: "DEPARTMENT ID",
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 158, 158, 158))),
                      obscureText: false,
                    )),
                const SizedBox(height: 20),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                              ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "PASSWORD",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 158, 158, 158))),
                      obscureText: false,
                    )),
                const SizedBox(height: 30),
                
                 ElevatedButton(
                       style: ElevatedButton.styleFrom(
                               primary: Colors.white, // background color
                            onPrimary: Colors.green, // text color
                             elevation: 5, // elevation
                         shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), // rounded corners
                              ),
                                    ),
                               onPressed: () {
                                          // onPressed handler
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const depthome()));
                              },
                               child: const Text('LOGIN'),
                             ),
                
              ],
            ),
          ),
        ));
  }
}
