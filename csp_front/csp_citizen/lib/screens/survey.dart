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
  double rating = 3.0; // Default rating value
  Client client = http.Client();
  List<SurveyQModel> events = [];
  List<TextEditingController> answerControllers = [];

  @override
  void initState() {
    _retrieveEvents();
    super.initState();
    final postEvent = Provider.of<SurveyQClass>(context, listen: false);
    postEvent.getPostData();
  }

  _retrieveEvents() async {
    events = [];
    List response = jsonDecode((await client.get(showQ)).body);
    for (var element in response) {
      events.add(SurveyQModel.fromJson(element));
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
                content: const Text('Success!'),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        events.removeAt(ind);
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
                content: const Text('Failed!'),
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
      elevation: 3,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: answerControllers[ind],
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Enter your feedback here...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            formattedDate,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 5,
          width: 50,
        ),
        // ignore: unnecessary_const
        ElevatedButton(
          onPressed: () {
            // Add logic to submit feedback for this card
            _submitFeedback(n, title, answerControllers[ind].text, ind);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 213, 213, 213),
            backgroundColor:
                const Color.fromARGB(255, 58, 58, 58), // Text color
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  2), // Adjust the border radius as needed
            ),
          ),
          child: const Text(
            'Submit Feedback',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildMultians(
      String n, String title, String date, List<String> options, int ind) {
    int selectedValue = -1;
    DateTime apiDate = DateTime.parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd').format(apiDate);
    return Card(
      elevation: 3,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
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
        const SizedBox(
          height: 3,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            formattedDate,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 5,
          width: 50,
        ),
        // ignore: unnecessary_const
        ElevatedButton(
          onPressed: () {
            // Add logic to submit feedback for this card
            _submitFeedback(n, title, options[selectedValue], ind);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 213, 213, 213),
            backgroundColor:
                const Color.fromARGB(255, 58, 58, 58), // Text color
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  2), // Adjust the border radius as needed
            ),
          ),
          child: const Text(
            'Submit Feedback',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Survey'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              answerControllers.add(TextEditingController());
              if (events[index].is_options) {
                return _buildMultians(
                    events[index].name,
                    events[index].question,
                    events[index].time,
                    events[index].options,
                    index);
              } else {
                return _buildFeedbackCard(events[index].name,
                    events[index].question, events[index].time, index);
              }
            },
          ),
        ),
      ),
      backgroundColor: const Color(0xFF698996),
    );
  }
}
