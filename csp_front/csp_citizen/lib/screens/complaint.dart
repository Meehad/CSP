import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({Key? key}) : super(key: key);

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedImagePath = '';
  String _selectedLocation = '';

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    try {
      final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _selectedImagePath = pickedFile.path;
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error picking image: $e');
      // Handle the error (show a dialog, log it, etc.)
    }
  }

  Future<void> _pickLocation() async {
    // Add logic to pick location using plugins like location
    // For simplicity, just setting a placeholder here
    setState(() {
      _selectedLocation = 'Latitude: 40.7128, Longitude: -74.0060';
    });
  }

  Future<void> _submitComplaint() async {
    // Add logic to submit the complaint
    // Access data from _subjectController.text, _descriptionController.text,
    // _selectedImagePath, and _selectedLocation
    // and send it to your backend or perform necessary actions
    // Reset or clear the form after submission if needed
    _subjectController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedImagePath = '';
      _selectedLocation = '';
    });
    // Show a success message or navigate to another screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Complaint Reporting', style: TextStyle(color: Colors.white)),
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
            _selectedImagePath.isNotEmpty
                ? Image.asset(
                    _selectedImagePath,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.attach_file, color: Color.fromARGB(255, 73, 64, 209)),
              label: const Text('Attach Image', style: TextStyle(color: Colors.white)),
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
              onPressed: _pickLocation,
              icon: const Icon(Icons.add_location, color: Color.fromARGB(255, 186, 40, 40)),
              label: const Text('Add Location', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
            ),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: _submitComplaint,
              child: const Text('Submit', style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 226, 252, 232),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ComplaintPage(),
  ));
}
