import 'dart:io';
import 'dart:typed_data';
import 'package:csp_citizen/screens/login.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
    final Directory output = await getTemporaryDirectory();
    final String screenshotFilePath = '${output.path}/feedback.png';
    final File screenshotFile = File(screenshotFilePath);
    await screenshotFile.writeAsBytes(feedbackScreenshot);
    return screenshotFilePath;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF97B1A6),
            ),
            child: Text(
              'Navigation',
              style: TextStyle(fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about');
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Survey'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/survey');
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/feedback');
            },
          ),
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text('Report a complaint'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/complaint');
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/help');
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.app_settings_alt),
          //   title: const Text('Preferences'),
          //   onTap: () {
          //     // Implement preferences functionality
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.bug_report),
            title: const Text('Report a bug'),
            onTap: () {
              BetterFeedback.of(context).show((feedback) async {
                final screenshotFilePath =
                    await writeImageToStorage(feedback.screenshot);

                final Email email = Email(
                  body: feedback.text,
                  subject: "Report a bug",
                  recipients: ['mohammedmihad2@gmail.com'],
                  attachmentPaths: [screenshotFilePath],
                  isHTML: false,
                );
                await FlutterEmailSender.send(email);
              });
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
