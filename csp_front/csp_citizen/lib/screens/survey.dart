import 'dart:convert';
import 'package:csp_citizen/models/survey_data.dart';
import 'package:csp_citizen/models/survey_model.dart';
import 'package:csp_citizen/models/user_data.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  Client client = http.Client();
  List<SurveyQModel> questions = [];
  List<TextEditingController> answerControllers = [];

  @override
  void initState() {
    _retrieveQ();
    super.initState();
    final postQ = Provider.of<SurveyQClass>(context, listen: false);
    postQ.getPostData();
  }

  _retrieveQ() async {
    questions = [];
    List response = jsonDecode((await client.get(showQ)).body);
    for (var element in response) {
      questions.add(SurveyQModel.fromJson(element));
    }
    setState(() {});
  }

  _submitFeedback(String n, String q, String t, int ind) async {
    try {
      final postModel = Provider.of<DataClass>(context, listen: false);
      postModel.getPostData();
      Response res = await post(postSurvey, body: {
        'name': n,
        'id_number': postModel.post?.id_number ?? "",
        'question': q,
        'answer': t,
      });
      if (res.statusCode == 201) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.grey[300],
                title: const Text('CSP'),
                content: const Text('Your feedback has been submitted successfully!'),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        questions.removeAt(ind);
                      });
                    },
                    child: const Text('ok'),
                  )
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.grey[300],
                title: const Text('CSP'),
                content: const Text('Failed to submit feedback. Please try again.'),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('ok'),
                  )
                ],
              );
            });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _buildFeedbackCard(String n, String title, String date, int ind) {
  DateTime apiDate = DateTime.parse(date);
  String formattedDate = DateFormat('yyyy-MM-dd').format(apiDate);

  return Card(
    elevation: 5,
    margin: const EdgeInsets.all(10),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: answerControllers[ind],
              maxLines: 4,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Enter your response here...',
                contentPadding: const EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            formattedDate,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // Add logic to submit feedback for this card
              _submitFeedback(n, title, answerControllers[ind].text, ind);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF698996), // Submit button color
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(double.infinity, 40), // Set button height
            ),
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildMultians(
    String n, String title, String date, List<String> options, int ind) {
  int selectedValue = -1;
  DateTime apiDate = DateTime.parse(date);
  String formattedDate = DateFormat('yyyy-MM-dd').format(apiDate);

  return Card(
    elevation: 5,
    margin: const EdgeInsets.all(10),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: options.map((option) {
                  return RadioListTile<int>(
                    title: Text(option),
                    value: options.indexOf(option),
                    groupValue: selectedValue,
                    onChanged: (int? value) {
                      setState(() {
                        selectedValue = value ?? -1;
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            formattedDate,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // Add logic to submit feedback for this card
              _submitFeedback(n, title, options[selectedValue], ind);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF698996), // Submit button color
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(double.infinity, 40), // Set button height
            ),
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            answerControllers.add(TextEditingController());
            if (questions[index].is_options) {
              return _buildMultians(
                  questions[index].name,
                  questions[index].question,
                  questions[index].time,
                  questions[index].options,
                  index);
            } else {
              return _buildFeedbackCard(questions[index].name,
                  questions[index].question, questions[index].time, index);
            }
          },
        ),
      ),
    );
  }
}
