import 'dart:io';
import 'package:csp_citizen/models/user_data.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({Key? key}) : super(key: key);

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImagePath;
  String _selectedLocation = '';
  late String lat;
  late String long;
  late String l;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    try {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _selectedImagePath = File(pickedFile.path);
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error picking image: $e');
      // Handle the error (show a dialog, log it, etc.)
    }
  }

  Future<Position> _pickLocation() async {
    // Add logic to pick location using plugins like location
    // For simplicity, just setting a placeholder here
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied");
    }

    return await Geolocator.getCurrentPosition();
  }

  void _submitComplaint(String Id, String s, String d, String l) async {
    final request = http.MultipartRequest(
      "POST",
      complainturl,
    );

    request.fields['id_number'] = Id;
    request.fields['sub'] = s;
    request.fields['prob'] = d;
    request.fields['loc'] = l;

    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile(
        'image',
        _selectedImagePath!.readAsBytes().asStream(),
        _selectedImagePath!.lengthSync(),
        filename: _selectedImagePath!.path.split("/").last));
    print(request);
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    setState(() {
      _selectedImagePath = null;
      _selectedLocation = '';
    });
    _subjectController.clear();
    _descriptionController.clear();
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
    final postModel = Provider.of<DataClass>(context, listen: false);
    postModel.getPostData();
  }

  Widget build(BuildContext context) {
    final postModel = Provider.of<DataClass>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Complaint Reporting',
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            _selectedImagePath == null
                ? Container()
                : Image.file(
                    _selectedImagePath as File,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.attach_file,
                  color: Color.fromARGB(255, 73, 64, 209)),
              label: const Text('Attach Image',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            const SizedBox(height: 4),
            _selectedLocation.isNotEmpty
                ? Text('Location: $_selectedLocation')
                : Container(),
            const SizedBox(height: 2),
            ElevatedButton.icon(
              onPressed: () {
                _pickLocation().then((value) {
                  lat = '${value.latitude}';
                  long = '${value.longitude}';
                  setState(() {
                    _selectedLocation = '$lat,$long';
                  });
                });
              },
              icon: const Icon(Icons.add_location,
                  color: Color.fromARGB(255, 186, 40, 40)),
              label: const Text('Add Location',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
            ),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: () {
                _submitComplaint(
                    postModel.post?.id_number ?? "",
                    _subjectController.text,
                    _descriptionController.text,
                    _selectedLocation);
              },
              child:
                  const Text('Submit', style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 226, 252, 232),
    );
  }
}
