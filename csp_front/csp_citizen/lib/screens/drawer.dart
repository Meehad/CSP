import 'package:csp_citizen/screens/login.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key});

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
            leading: Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about');
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: const Text('Survey'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/survey');
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/feedback');
            },
          ),
          ListTile(
            leading: Icon(Icons.report),
            title: const Text('Report a complaint'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/complaint');
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.app_settings_alt),
            title: const Text('Preferences'),
            onTap: () {
              // Implement preferences functionality
            },
          ),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: const Text('Report a bug'),
            onTap: () {
              BetterFeedback.of(context).show((feedback) async {});
            },
          ),
          ListTile(
            leading: Icon(
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
