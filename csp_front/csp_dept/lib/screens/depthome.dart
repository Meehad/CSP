// ignore_for_file: camel_case_types

import 'package:csp_dept/screens/deptdetails.dart';
import 'package:csp_dept/screens/deptevent.dart';
import 'package:csp_dept/screens/deptform.dart';
import 'package:csp_dept/screens/deptviewdata.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
                      const SizedBox(height: 50),
     CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.9,
              ),
              items: [
                // Add your image items here
                Image.network('https://images.moneycontrol.com/static-mcnews/2021/04/P-Vijayan-770x433.jpg?impolicy=website&width=770&height=431', fit: BoxFit.cover),
                
                Image.network('https://1.bp.blogspot.com/-FwixDe2oaT0/YNidS5zzGEI/AAAAAAAA7_E/roj_M-86vcEG6wZUM0pSflsFkBBH7M9iwCLcBGAsYHQ/s0/govt-of-kerala-mobile-apps.webp', fit: BoxFit.cover),
               
                // Add more images as needed
              ],)
        
        ],),
      )

    );
  }
}