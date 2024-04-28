// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:csp_dept/widgets/surveyformCard.dart';
import 'package:flutter/material.dart';

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
          child: Text(
            'SURVEY SECTION',
            style: TextStyle(color: Colors.white),
          ),
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
