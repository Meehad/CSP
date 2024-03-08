import 'package:csp_citizen/screens/login.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

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
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              title: const Text('Survey'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/survey');
              },
            ),
            ListTile(
              title: const Text('Feedback'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/feedback');
              },
            ),
            ListTile(
              title: const Text('Report a complaint'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/complaint');
              },
            ),
            ListTile(
              title: const Text('Help'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Preferences'),
              onTap: () {
                
              },
            ),
            ListTile(
              title: const Text('Report a bug'),
              onTap: () {
                BetterFeedback.of(context).show((feedback) async {});
              },
            ),
            ListTile(
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