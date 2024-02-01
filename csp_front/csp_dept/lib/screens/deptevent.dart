import 'package:flutter/material.dart';

// ignore: camel_case_types
class deptevent extends StatefulWidget {
  const deptevent({Key? key}) : super(key: key);

  @override
  State<deptevent> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<deptevent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(146, 245, 142, 1),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 50.0),
          child: Center(
            child: Text(
              'EVENT SECTION',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: EventForm(),
      ),
    );
  }
}

class EventForm extends StatefulWidget {
  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _eventDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Name
            TextFormField(
              controller: _eventNameController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "EVENT NAME",
                hintStyle: TextStyle(color: Color.fromARGB(255, 158, 158, 158)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the event name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            // Event Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _eventDateController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: const Color.fromRGBO(255, 255, 255, 1),
                    filled: true,
                    hintText: "EVENT DATE",
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 158, 158, 158),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the event date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 35.0),
                // Add Picture IconButton (No functionality)
                Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_a_photo, color: Colors.black,size: 36.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50.0),
            // Submit Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.green,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform form submission
                    print('Event Name: ${_eventNameController.text}');
                    print('Event Date: ${_eventDateController.text}');
                  }
                },
                child: const Text('SUBMIT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
