import 'package:csp_dept/widgets/cards.dart';
import 'package:flutter/material.dart';

class deptform extends StatefulWidget {
  const deptform({super.key});

  @override
  State<deptform> createState() => _deptformState();
}

class _deptformState extends State<deptform> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 50.0),
          child: Center(
            child: Text(
              'FORMS SECTION',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: QuestionForm(),
      ),
    );
  }
}

class QuestionForm extends StatefulWidget {
  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> questions = [];
  TextEditingController tbox = TextEditingController();

  void _addQuestion(String question) {
    setState(() {
      questions.add(question);
    });
  }

  List<QuestionCard> questionCards = [];
  String selectedValue = "Short Answer";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var card in questionCards) card,
          SizedBox(height: 16),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                TextField(
                  controller: tbox,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "QUESTION",
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      value: selectedValue,
                      items: ["Short Answer", "Multiple Choice"]
                          .map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                    ),
                    SizedBox(width: 5),
                    IconButton(
                      onPressed: () {
                        _addQuestionCard();
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              onPrimary: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              // Handle submit logic here
            },
            child: const Text('SUBMIT'),
          ),
        ],
      ),
    );
  }

  void _addQuestionCard() {
    setState(() {
      questionCards.add(QuestionCard(
        question: tbox.text,
        type: selectedValue,
        onDelete: () {
          _removeQuestionCard(questionCards.length - 1);
        },
      ));
    });
  }

  void _removeQuestionCard(int index) {
    setState(() {
      questionCards.removeAt(index);
    });
  }
}

class QuestionCard extends StatelessWidget {
  final String question;
  final String type;
  final VoidCallback onDelete;

  const QuestionCard({
    required this.question,
    required this.type,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(question),
            subtitle: Text(type),
            trailing: IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.remove),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Cards(),
    ),
  ));
}
