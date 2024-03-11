// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:csp_dept/models/dept_data.dart';
import 'package:csp_dept/models/survey_data.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SurveyApp extends StatefulWidget {
  const SurveyApp({super.key});

  @override
  _SurveyAppState createState() => _SurveyAppState();
}

class _SurveyAppState extends State<SurveyApp> {
  List<SurveyCard> surveyCards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 40),
          child: Text('SURVEY SECTION'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddCardDialog(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: surveyCards.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(surveyCards[index].hashCode.toString()),
            onDismissed: (direction) {
              _deleteSurveyCard(index);
            },
            child: surveyCards[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCardDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addSurveyCard(bool isMultipleChoice, int numberOfChoices) {
    setState(() {
      surveyCards.add(SurveyCard(
        onDelete: () {
          _deleteSurveyCard(surveyCards.length - 1);
        },
        isMultipleChoice: isMultipleChoice,
        numberOfChoices: numberOfChoices,
        onSubmit: () {
          _deleteSurveyCard(surveyCards.length - 1);
        },
      ));
    });
  }

  void _deleteSurveyCard(int index) {
    setState(() {
      surveyCards.removeAt(index);
    });
  }

  Future<void> _showAddCardDialog(BuildContext context) async {
    bool? isMultipleChoice = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Card Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Multiple Choice
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text(
                  'Multiple Choice',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Short Answer
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text(
                  'Short Answer',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (isMultipleChoice != null) {
      if (isMultipleChoice) {
        int? numberOfChoices = await showDialog<int>(
          context: context,
          builder: (BuildContext context) {
            TextEditingController controller = TextEditingController();
            return AlertDialog(
              title: const Text('Enter Number of Choices'),
              content: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(int.tryParse(controller.text));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 16, 185, 185)),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
        if (numberOfChoices != null) {
          _addSurveyCard(isMultipleChoice, numberOfChoices);
        }
      } else {
        _addSurveyCard(isMultipleChoice, 0);
      }
    }
  }
}

class SurveyCard extends StatefulWidget {
  final VoidCallback onDelete;
  final VoidCallback onSubmit;
  final bool isMultipleChoice;
  final int numberOfChoices;

  const SurveyCard({
    super.key,
    required this.onDelete,
    required this.onSubmit,
    required this.isMultipleChoice,
    required this.numberOfChoices,
  });

  @override
  _SurveyCardState createState() => _SurveyCardState();
}

class _SurveyCardState extends State<SurveyCard> {
  TextEditingController questionController = TextEditingController();
  List<String> options = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.numberOfChoices; i++) {
      options.add('Option ${i + 1}');
    }
  }

  void _submitSurveyQ(String q, bool iso, List<String?> l) async {
    try {
      final postModel = Provider.of<DeptDataClass>(context);
      postModel.getPostData();
      final postSurvey = Provider.of<SurveyClass>(context);
      postSurvey.getPostData(postModel.post?.name ?? "");

      // Send survey data to the DRF API
      final response = await http.post(
        survey_create, // Replace with your DRF API endpoint
        body: jsonEncode({
          'name': postModel.post?.name ?? "",
          'question': q,
          'isMultipleChoice': iso,
          'options': l,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {
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
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
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
                    //   setState(() {
                    //   // SurveyCards.removeLast();
                    // });
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }

      FocusScope.of(context).unfocus();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: widget.onDelete,
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: questionController,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                labelText: 'Enter your question',
                labelStyle: TextStyle(color: Colors.blue),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (widget.isMultipleChoice)
              for (int i = 0; i < options.length; i++)
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            options[i] = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Option ${i + 1}',
                            labelStyle: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            options.removeAt(i);
                          });
                        },
                      ),
                    ],
                  ),
                ),
            if (!widget.isMultipleChoice)
              ListTile(
                title: TextFormField(
                  onChanged: (value) {
                    // Handle short answer
                  },
                  decoration: const InputDecoration(
                    labelText: 'Short Answer',
                    labelStyle: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            if (widget.isMultipleChoice)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        options.add('Option ${options.length + 1}');
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 16, 185, 185)),
                    child: const Text(
                      'Add Option',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.onSubmit(); // Call the new function on submit
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 16, 185, 185),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            if (!widget.isMultipleChoice)
              ElevatedButton(
                onPressed: () {
                  widget.onSubmit(); // Call the new function on submit
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
