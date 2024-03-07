import 'package:csp_citizen/models/user_data.dart';
// ignore: unused_import
import 'package:csp_citizen/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart'; // Import your login page file

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    final postModel = Provider.of<DataClass>(context, listen: false);
    postModel.getPostData();
  }

  Widget build(BuildContext context) {
    final postModel = Provider.of<DataClass>(context);
    final String img = postModel.post?.image ?? "";
    final String img_url = "http://10.0.2.2:8000$img";
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 170, bottom: 180), //white container dimensions
          child: Container(
            padding: const EdgeInsets.all(15.0),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70.0,
                  backgroundImage: NetworkImage(
                      img_url), //NetworkImage("http://10.0.2.2:8000" +img_url),
                ),
                const SizedBox(height: 4),
                Text(
                  // 'Tyler Durden'
                  postModel.post?.name ?? "",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Phone no:',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 43, 43, 43)),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      postModel.post?.phone_number ?? "",
                      // (currentUser.phoneNumber).toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 43, 43, 43)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Date of Birth:',
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 40, 40, 40)),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      postModel.post?.date_of_birth ?? "",
                      // currentUser.dob,
                      style: const TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 40, 40, 40)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
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
            const SizedBox(height: 20),
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  // Navigate to the login page
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => false,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
