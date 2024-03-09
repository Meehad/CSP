import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help: On how to use CSP'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Central Service Portal',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Version: 1.0.0',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const Text(
                'Welcome to Central Service Portal, your digital gateway to an empowered and engaged civic experience. This mobile application serves as the centralized hub for effective communication between citizens and various government service departments. Explore the key features and benefits that make Central Service Portal a transformative force in shaping the future of public services.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              const Text(
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
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          point1,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 5),
        Text(
          point2,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 5),
        Text(
          point3,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
