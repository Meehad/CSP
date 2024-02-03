import 'package:flutter/material.dart';
import 'login.dart'; // Import your login page file

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 175, bottom: 185), //white container dimensions
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white, // Box background color
              borderRadius:
                  BorderRadius.circular(10.0), // Optional: add rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70.0,
                  backgroundImage: AssetImage('assets/profile1.jpg'),
                ),
                SizedBox(height: 16),
                Text(
                  'Tyler Durden',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Phone no: +91 7893458254',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 43, 43, 43)),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                Text(
                  'Date of Birth: 18/12/1963',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 40, 40, 40)),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.green,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // Navigate to the login page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ProfilePage(),
  ));
}
