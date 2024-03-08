// import 'package:flutter/material.dart';

// class AboutPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('About Central Service Portal'),
//       ),
//       body: const Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'Central Service Portal',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 12),
//             Text(
//               'Version: 1.0.0',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Welcome to Central Service Portal, your digital gateway to an empowered and engaged civic experience. This mobile application serves as the centralized hub for effective communication between citizens and various government service departments. Explore the key features and benefits that make Central Service Portal a transformative force in shaping the future of public services.',
//               style: TextStyle(fontSize: 16),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 10),
//             Text(
//               '1. Surveys: - Engage in government-initiated surveys on critical public service matters. - Share your insights and opinions, influencing decision-making processes.  - Access detailed survey analytics for informed and data-driven enhancements.',
//               style: TextStyle(fontSize: 16),
//               textAlign: TextAlign.left,
//             ),
//             SizedBox(height: 5),
//             Text(
//               '2. Feedback:- Provide constructive feedback on government services and initiatives.- Foster transparent communication with service providers for continuous improvement.- Stay informed about the impact of your feedback on service enhancements.',
//               style: TextStyle(fontSize: 16),
//               textAlign: TextAlign.left,
//             ),
//             SizedBox(height: 5),
//             Text(
//               '3. Complaints:- Report service-related issues directly to relevant government departments - Monitor real-time status updates and resolution progress for reported complaints. - Collaborate with service providers and fellow citizens for effective issue resolution.',
//               style: TextStyle(fontSize: 16),
//               textAlign: TextAlign.left,
//             ),
//             SizedBox(height: 10),
//             Text(
//               '© 2024 CSP',
//               style: TextStyle(fontSize: 14),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Central Service Portal'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Central Service Portal',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Version: 1.0.0',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome to Central Service Portal, your digital gateway to an empowered and engaged civic experience. This mobile application serves as the centralized hub for effective communication between citizens and various government service departments. Explore the key features and benefits that make Central Service Portal a transformative force in shaping the future of public services.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              _buildFeatureText(
                '1. Surveys:',
                '   - Engage in government-initiated surveys on critical public service matters.',
                '   - Share your insights and opinions, influencing decision-making processes.',
                '   - Access detailed survey analytics for informed and data-driven enhancements.',
              ),
              _buildFeatureText(
                '2. Feedback:',
                '   - Provide constructive feedback on government services and initiatives.',
                '   - Foster transparent communication with service providers for continuous improvement.',
                '   - Stay informed about the impact of your feedback on service enhancements.',
              ),
              _buildFeatureText(
                '3. Complaints:',
                '   - Report service-related issues directly to relevant government departments.',
                '   - Monitor real-time status updates and resolution progress for reported complaints.',
                '   - Collaborate with service providers and fellow citizens for effective issue resolution.',
              ),
              SizedBox(height: 16),
              Text(
                '© 2024 CSP',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureText(String title, String point1, String point2, String point3) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          point1,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 5),
        Text(
          point2,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 5),
        Text(
          point3,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
