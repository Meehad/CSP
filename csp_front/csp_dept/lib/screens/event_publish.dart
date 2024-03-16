import 'dart:io';
import 'package:csp_dept/models/dept_data.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Event_publish extends StatefulWidget {
  const Event_publish({super.key});

  @override
  State<Event_publish> createState() => _Event_publishState();
}

class _Event_publishState extends State<Event_publish> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDescController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    try {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error picking image: $e');
      // Handle the error (show a dialog, log it, etc.)
    }
  }

  void _submitEvent(String n, String en, String ed) async {
    final request = http.MultipartRequest(
      "POST",
      eventUrl,
    );

    request.fields['name'] = n;
    request.fields['event_name'] = en;
    request.fields['event_details'] = ed;

    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile('event_img',
        _selectedImage!.readAsBytes().asStream(), _selectedImage!.lengthSync(),
        filename: _selectedImage!.path.split("/").last));
    print(request);
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    setState(() {
      _selectedImage = null;
    });
    _eventDescController.clear();
    _eventNameController.clear();
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
  }

  @override
  void initState() {
    super.initState();
    final postModel = Provider.of<DeptDataClass>(context, listen: false);
    postModel.getPostData();
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DeptDataClass>(context);
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
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
              const SizedBox(height: 16),
              TextField(
                controller: _eventDescController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 35.0),
              // Add Picture IconButton (with functionality)
              _selectedImage == null
                  ? Container()
                  : Image.file(
                      _selectedImage as File,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(height: 8),
              IconButton(
                onPressed: _pickImage,
                icon: const Center(
                  child: Icon(Icons.add_a_photo,
                      color: Colors.black, size: 36.0),
                ),
              ),
              const SizedBox(height: 50.0),
              // Submit Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    _submitEvent(
                      postModel.post?.name ?? "",
                      _eventNameController.text,
                      _eventDescController.text,
                    );
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.only(left: 90, right: 90, top: 15, bottom: 15),
                    child: Text('SUBMIT', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
