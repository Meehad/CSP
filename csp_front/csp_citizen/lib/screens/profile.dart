import 'package:csp_citizen/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DataClass>(context);
    final String img = postModel.post?.image ?? "";
    final String imgUrl = "http://192.168.0.187:8000$img";

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 20.0, right: 20, top: 10, bottom: 15),
          child: Card(
            elevation: 5,
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 20,
                  top: 90,
                  bottom: 70.0), //text boxes inside card size
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70.0,
                    backgroundImage: NetworkImage(imgUrl),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    postModel.post?.name ?? "",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 234, 234, 234),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoBox(
                          'Phone No:. ${postModel.post?.phone_number ?? ""}',
                        ),
                        const SizedBox(height: 16),
                        _buildInfoBox(
                          'Date of Birth :. ${postModel.post?.date_of_birth ?? ""}',
                        ),
                        const SizedBox(height: 16),
                        _buildInfoBox(
                          'Gender :. Male',
                        ),
                        const SizedBox(height: 16),
                        _buildInfoBox(
                          'Aadhaar ID :. 2012022022',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // backgroundColor: Color(0xFFC9C5BA),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  Widget _buildInfoBox(String text) {
    return Container(
      width: 300.0,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text.split(".")[0], // Extracting label before ":"
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: text.split(".")[1], // Extracting text after ":"
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
