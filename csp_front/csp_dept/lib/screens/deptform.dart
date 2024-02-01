import 'package:flutter/material.dart';

// ignore: camel_case_types
class deptform extends StatefulWidget {
  const deptform({super.key});

  @override
  State<deptform> createState() => _deptformState();
}

// ignore: camel_case_types
class _deptformState extends State<deptform> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
             backgroundColor: const Color.fromRGBO(146, 245, 142, 1),
      appBar: AppBar(
        title:  const Padding(
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

  void _addQuestion(String question) {
    setState(() {
      questions.add(question);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Questions
          for (String question in questions)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(question),
            ),
            const SizedBox(height: 50,),
          // Question Input
          TextFormField(
             decoration:  InputDecoration(
                          enabledBorder:  OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(30.0)),
                          focusedBorder: const OutlineInputBorder(

                              borderSide: BorderSide(color: Colors.white),
                              ),
                          fillColor: const Color.fromRGBO(255, 255, 255, 1),

                          filled: true,
                          hintText: "ENTER A QUESTION",
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 158, 158, 158))),
            
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a question';
              }
              return null;
            },
            onSaved: (value) {
              _addQuestion(value!);
            },
          ),
          const SizedBox(height: 30,),
          // Add Question Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                                 primary: Colors.white, // background color
                              onPrimary: Colors.green, // text color
                               elevation: 5, // elevation
                           shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // rounded corners
                                ),
                        ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
            },
            child: const Text('ADD QUESTION'),
          ),
          const SizedBox(height: 30,),
       ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                 primary: Colors.white, // background color
                              onPrimary: Colors.green, // text color
                               elevation: 5, // elevation
                           shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // rounded corners
                                ),
                        ),onPressed: (){},                                                      
                        child: const Text('SUBMIT'),
                      ),

       
        ],
      ),
    );
  }
}



    