import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Event_publish extends StatefulWidget {
  const Event_publish({super.key});

  @override
  State<Event_publish> createState() => _Event_publishState();
}

class _Event_publishState extends State<Event_publish> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _eventDateController = TextEditingController();
  XFile? _selectedImage;
  
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
                // Add Picture IconButton (with functionality)
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_selectedImage != null)
                        CircleAvatar(
                          backgroundImage:
                              FileImage(File(_selectedImage!.path)),
                          radius: 50,
                        ),
                      IconButton(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.add_a_photo,
                            color: Colors.black, size: 36.0),
                      ),
                    ],
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
                  onPrimary: Colors.teal[900],
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform form submission
                    print('Event Name: ${_eventNameController.text}');
                    print('Event Date: ${_eventDateController.text}');
                    if (_selectedImage != null) {
                      print('Selected Image: ${_selectedImage!.path}');
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 90,right: 90,top: 15,bottom: 15),
                  child: const Text('SUBMIT', style: TextStyle(fontSize: 20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = image;
    });
  }
}
