// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
import 'package:csp_dept/models/dept_data.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

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

  _submitOptionSurvey(String q, bool t, List<String> op) async {
    try {
      final postModel = Provider.of<DeptDataClass>(context, listen: false);
      postModel.getPostData();

      Response res = await post(survey_create, body: {
        'name': postModel.post?.name ?? "",
        'question': q,
        'is_options': t.toString(),
        for (int i = 0; i < op.length; i += 1) 'options[$i]': op[i]
      });

      if (res.statusCode == 201) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.grey[300],
              title: const Text('CSP'),
              content: const Text(
                  'Your Questions for survey has been submitted successfully!'),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Use Future.delayed to call setState after the build phase is complete
                    Future.delayed(Duration.zero, () {
                      setState(() {
                        widget.onSubmit(); // Call the new function on submit
                      });
                    });
                  },
                  child: const Text('ok'),
                )
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
              content: const Text(
                  'Failed to submit questions for Survey. Please try again.'),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('ok'),
                )
              ],
            );
          },
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  _submitSurvey(String q, bool t) async {
    try {
      final postModel = Provider.of<DeptDataClass>(context, listen: false);
      postModel.getPostData();

      Response res = await post(survey_create, body: {
        'name': postModel.post?.name ?? "",
        'question': q,
        'is_options': t.toString(),
      });
      if (res.statusCode == 201) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.grey[300],
              title: const Text('CSP'),
              content: const Text(
                  'Your Questions for survey has been submitted successfully!'),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Use Future.delayed to call setState after the build phase is complete
                    Future.delayed(Duration.zero, () {
                      setState(() {
                        widget.onSubmit(); // Call the new function on submit
                      });
                    });
                  },
                  child: const Text('ok'),
                )
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
              content: const Text(
                  'Failed to submit questions for Survey. Please try again.'),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('ok'),
                )
              ],
            );
          },
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
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
                    ],
                  ),
                ),
            if (!widget.isMultipleChoice)
              const ListTile(
                title: Text(
                  'Short Answer',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            const SizedBox(height: 16),
            if (widget.isMultipleChoice)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        options.removeAt(options.length - 1);
                      });
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 16, 185, 185),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        setState(() {
                          options.add('Option ${options.length + 1}');
                        });
                      });
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 16, 185, 185),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 50),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _submitOptionSurvey(questionController.text,
                            widget.isMultipleChoice, options);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 16, 185, 185),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            if (!widget.isMultipleChoice)
              ElevatedButton(
                onPressed: () {
                  _submitSurvey(
                      questionController.text, widget.isMultipleChoice);
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
