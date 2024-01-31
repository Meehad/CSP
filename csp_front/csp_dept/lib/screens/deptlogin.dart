import 'package:flutter/material.dart';




// ignore: camel_case_types
class deptlogin  extends StatelessWidget {
  const deptlogin({super.key});
  

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 106, 233, 110),
      body: SafeArea(
            child: Center(
              child: Column(
                         children: [
                           SizedBox(height: 10),

                      Icon(Icons.login_sharp,
                      size:75,
                      ),
                      SizedBox(height: 50),

                      Text("WELCOME TO CSP",
                           style: TextStyle(
                           color: Color.fromARGB(179, 253, 251, 251),
                           fontSize: 25
                           ),
                      ),

                      
                        Padding(
                          padding: EdgeInsets.all(10.0),
                         child: Image(image: AssetImage('assets/logo.png')
                          
                          ),
                        ),
                     

                    

                      Padding
                      (padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "DEPARTMENT ID / ADMIN ID",
                          hintStyle: TextStyle(color: Color.fromARGB(255, 158, 158, 158))
                        ),
                        obscureText: false,
                      )
                      ),                   
               
              
                         ],
              
                    ),
            ),







      )
    );
  }
}