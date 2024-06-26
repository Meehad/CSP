import 'dart:io';
import 'dart:typed_data';
import 'package:csp_dept/screens/deptlogin.dart';
import 'package:csp_dept/screens/pdf_upload.dart';
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
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Text(
              'Navigation',
              style: TextStyle(fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/dept_details');
            },
          ),

          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Create Form'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/survey');
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Publish an Event'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/event');
            },
          ),
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text('View Data'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/dataview');
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_copy),
            title: const Text('Forms upload'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UploadPDFPage()),
              );
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
                  recipients: ['centralserviceportal.com'],
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
                MaterialPageRoute(builder: (context) => const DeptLogin()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
