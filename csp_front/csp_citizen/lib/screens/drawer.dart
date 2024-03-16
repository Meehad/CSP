import 'dart:io';
import 'dart:typed_data';
import 'package:csp_citizen/screens/login.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
              color: Theme.of(context).drawerTheme.backgroundColor ,
            ),
            child: const Text(
              'Navigation',
              style: TextStyle(fontSize: 25),
            ),
          ).animate().fadeIn(delay: 800.ms).scaleX(),
          ListTile(
            leading: const Icon(Icons.person).animate().fadeIn(delay: 2000.ms).scaleX(),
            title: const Text('Profile').animate().fadeIn(delay: 2000.ms).scaleX(),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info).animate().fadeIn(delay: 2300.ms).scaleX(),
            title: const Text('About').animate().fadeIn(delay: 2300.ms).scaleX(),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about');
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment).animate().fadeIn(delay: 2600.ms).scaleX(),
            title: const Text('Survey').animate().fadeIn(delay: 2600.ms).scaleX(),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/survey');
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback).animate().fadeIn(delay: 2900.ms).scaleX(),
            title: const Text('Feedback').animate().fadeIn(delay: 2900.ms).scaleX(),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/feedback');
            },
          ),
          ListTile(
            leading: const Icon(Icons.report).animate().fadeIn(delay: 3200.ms).scaleX(),
            title: const Text('Report a complaint').animate().fadeIn(delay: 3200.ms).scaleX(),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/complaint');
            },
          ),
          ListTile(
            leading: const Icon(Icons.help).animate().fadeIn(delay: 3500.ms).scaleX(),
            title: const Text('Help').animate().fadeIn(delay: 3500.ms).scaleX(),
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
            leading: const Icon(Icons.bug_report).animate().fadeIn(delay: 3800.ms).scaleX(),
            title: const Text('Report a bug').animate().fadeIn(delay: 3800.ms).scaleX(),
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
            ).animate().fadeIn(delay: 4100.ms).scaleX(),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.red,
              ),
            ).animate().fadeIn(delay: 4100.ms).scaleX(),
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
