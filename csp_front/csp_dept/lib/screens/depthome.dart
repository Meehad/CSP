// import 'package:csp_dept/screens/deptdetails.dart';
// import 'package:csp_dept/screens/deptevent.dart';
// import 'package:csp_dept/screens/deptform.dart';
// import 'package:csp_dept/screens/deptviewdata.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class Depthome extends StatefulWidget {
//   const Depthome({Key? key});

//   @override
//   State<Depthome> createState() => _DepthomeState();
// }

// class _DepthomeState extends State<Depthome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.teal[400],
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Padding(
//           padding: const EdgeInsets.only(left: 60.0),
//           child: Center(
//             child: Text(
//               'CSP',
//               style: TextStyle(color: Colors.black, fontSize: 25),
//             ),
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pushNamed(context, '/dept_details');
//             },
//             icon: const Icon(
//               Icons.list,
//               color: Colors.black,
//             ),
//             iconSize: 45.0,
//           )
//         ],
//         backgroundColor: Colors.white,
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             const SizedBox(height: 50),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.white,
//                 onPrimary: Colors.teal[900],
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.pushNamed(context, '/survey');
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     left: 90, right: 90, top: 15, bottom: 15),
//                 child:
//                     const Text('CREATE FORM', style: TextStyle(fontSize: 20)),
//               ),
//             ),
//             const SizedBox(height: 50),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.white,
//                 onPrimary: Colors.teal[900],
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => const deptevent()),
//                 );
//               },
//               child: Padding(
//                 padding:
//                     EdgeInsets.only(left: 90, right: 90, top: 15, bottom: 15),
//                 child: const Text('PUBLISH AN EVENT',
//                     style: TextStyle(fontSize: 20)),
//               ),
//             ),
//             const SizedBox(height: 50),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.white,
//                 onPrimary: Colors.teal[900],
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => const DeptViewData()),
//                 );
//               },
//               child: Padding(
//                 padding:
//                     EdgeInsets.only(left: 90, right: 90, top: 15, bottom: 15),
//                 child: const Text('VIEW DATA', style: TextStyle(fontSize: 20)),
//               ),
//             ),
//             const SizedBox(height: 50),
//             CarouselSlider(
//               options: CarouselOptions(
//                 height: 300.0,
//                 enlargeCenterPage: true,
//                 autoPlay: true,
//                 aspectRatio: 16 / 9,
//                 autoPlayCurve: Curves.fastOutSlowIn,
//                 enableInfiniteScroll: true,
//                 autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                 viewportFraction: 0.9,
//               ),
//               items: [
//                 Image.network(
//                   'https://images.moneycontrol.com/static-mcnews/2021/04/P-Vijayan-770x433.jpg?impolicy=website&width=770&height=431',
//                   fit: BoxFit.cover,
//                 ),
//                 Image.network(
//                   'https://1.bp.blogspot.com/-FwixDe2oaT0/YNidS5zzGEI/AAAAAAAA7_E/roj_M-86vcEG6wZUM0pSflsFkBBH7M9iwCLcBGAsYHQ/s0/govt-of-kerala-mobile-apps.webp',
//                   fit: BoxFit.cover,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:csp_dept/screens/deptdetails.dart';
import 'package:csp_dept/screens/deptevent.dart';
import 'package:csp_dept/screens/deptform.dart';
import 'package:csp_dept/screens/deptviewdata.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Depthome extends StatefulWidget {
  const Depthome({Key? key});

  @override
  State<Depthome> createState() => _DepthomeState();
}

class _DepthomeState extends State<Depthome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 60.0),
          child: Center(
            child: Text(
              'CSP',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => deptdetails()),
              );
            },
            icon: const Icon(
              Icons.list,
              color: Colors.black,
            ),
            iconSize: 45.0,
          )
        ],
        backgroundColor: Colors.teal[400],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.teal[900],
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/survey');
              },
              child: const Padding(
                padding:
                    EdgeInsets.only(left: 90, right: 90, top: 15, bottom: 15),
                child: Text('CREATE FORM', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.teal[900],
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const deptevent()),
                );
              },
              child: const Padding(
                padding:
                    EdgeInsets.only(left: 65, right: 65, top: 15, bottom: 15),
                child: Text('PUBLISH AN EVENT', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.teal[900],
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const DeptViewData()),
                );
              },
              child: const Padding(
                padding:
                    EdgeInsets.only(left: 105, right: 105, top: 15, bottom: 15),
                child: Text('VIEW DATA', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 40),
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
                Image.network(
                  'https://images.moneycontrol.com/static-mcnews/2021/04/P-Vijayan-770x433.jpg?impolicy=website&width=770&height=431',
                  fit: BoxFit.cover,
                ),
                Image.network(
                  'https://1.bp.blogspot.com/-FwixDe2oaT0/YNidS5zzGEI/AAAAAAAA7_E/roj_M-86vcEG6wZUM0pSflsFkBBH7M9iwCLcBGAsYHQ/s0/govt-of-kerala-mobile-apps.webp',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
