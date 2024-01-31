// ignore_for_file: camel_case_types

import 'package:csp_dept/screens/deptdetails.dart';
import 'package:flutter/material.dart';

class depthome extends StatefulWidget {
  const depthome({super.key});

  @override
  State<depthome> createState() => _depthomeState();
}

class _depthomeState extends State<depthome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.green,
      appBar: AppBar(
        title:  const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Center(
            child: Text(
              'CSP',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const deptdetails()));
          }, icon: const Icon(Icons.list,),iconSize:45.0,)
        ],
      ),
      body:
           
      Center(
        child: Column(children: [

          const SizedBox(height: 50,),
        
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                 primary: Colors.white, // background color
                              onPrimary: Colors.green, // text color
                               elevation: 5, // elevation
                           shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // rounded corners
                                ),
                        ),onPressed: (){},
                        child: Text('CREATE FORM'),
                      ),
                       const SizedBox(height: 50,),
        
                      
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                 primary: Colors.white, // background color
                              onPrimary: Colors.green, // text color
                               elevation: 5, // elevation
                           shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // rounded corners
                                ),
                        ),onPressed: (){},
                        child: Text('PUBLISH AN EVENT'),
                      ),

                      const SizedBox(height: 50,),
        
                      
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                 primary: Colors.white, // background color
                              onPrimary: Colors.green, // text color
                               elevation: 5, // elevation
                           shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // rounded corners
                                ),
                        ),onPressed: (){},
                        child: Text('VIEW DATA'),
                      ),


        
        
        
        
        ],),
      )

    );
  }
}