// ignore_for_file: camel_case_types

import 'package:csp_dept/screens/deptdetails.dart';
import 'package:csp_dept/screens/deptevent.dart';
import 'package:csp_dept/screens/deptform.dart';
import 'package:csp_dept/screens/deptviewdata.dart';
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
          padding: EdgeInsets.only(left: 5.0),
          child: Center(
            child: Text(
              'CSP',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  deptdetails()));
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
                              borderRadius: BorderRadius.circular(15), // rounded corners
                                ),
                        ),onPressed: (){

                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const deptform()));
                              
                        },
                        child: const Text('CREATE FORM',style: TextStyle(fontSize: 18),),
                      ),
                       const SizedBox(height: 50,),
        
                      
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                 primary: Colors.white, // background color
                              onPrimary: Colors.green, // text color
                               elevation: 5, // elevation
                           shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // rounded corners
                                ),
                        ),onPressed: (){
                           Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const deptevent()));
                        },
                        child: const Text('PUBLISH AN EVENT',style: TextStyle(fontSize: 18),),
                      ),

                      const SizedBox(height: 50,),
        
                      
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                 primary: Colors.white, // background color
                              onPrimary: Colors.green, // text color
                               elevation: 5, // elevation
                           shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // rounded corners
                                ),
                        ),onPressed: (){
                           Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const deptviewdata()));
                        },
                        child: const Text('VIEW DATA',style: TextStyle(fontSize: 18),),
                      ),

                      
        
        
        
        
        ],),
      )

    );
  }
}