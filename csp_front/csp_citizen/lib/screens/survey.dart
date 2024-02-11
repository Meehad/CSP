import 'package:flutter/material.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({Key? key}) : super(key: key);

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  Map<int, String?> selectedAnswers = {};

  final List<Map<String, dynamic>> surveyData = [
    {
      'question': 'How satisfied are you with our service?',
      'options': ['Very Satisfied', 'Satisfied', 'Neutral', 'Dissatisfied', 'Very Dissatisfied', 'Other'],
    },
    {
      'question': 'Would you recommend our app to a friend?',
      'options': ['Definitely Yes', 'Probably Yes', 'Not Sure', 'Probably No', 'Definitely No', 'Other'],
    },
    // Add more questions and answer options as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text(
          'Survey',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: surveyData.length,
          itemBuilder: (context, index) {
            return _buildQuestionCard(index);
          },
        ),
      ),
    );
  }

  Widget _buildQuestionCard(int index) {
    final question = surveyData[index]['question'] as String;
    final options = surveyData[index]['options'] as List<String>;

    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Q${index + 1}: $question',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildAnswerOptions(index + 1, options),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(int questionNumber, List<String> options) {
    return Column(
      children: options.map((option) {
        return option == 'Other'
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your answer',
                  ),
                  onChanged: (text) {
                    selectedAnswers[questionNumber] = text;
                  },
                ),
              )
            : RadioListTile<String>(
                title: Text(
                  option,
                  style: const TextStyle(color: Colors.black),
                ),
                value: option,
                groupValue: selectedAnswers[questionNumber],
                onChanged: (value) {
                  setState(() {
                    selectedAnswers[questionNumber] = value!;
                  });
                },
                activeColor: Colors.green,
              );
      }).toList(),
    );
  }
}