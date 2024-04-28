// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'package:csp_dept/models/dept_data.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

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