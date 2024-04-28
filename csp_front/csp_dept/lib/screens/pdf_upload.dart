// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';
import 'package:csp_dept/models/dept_data.dart';
import 'package:csp_dept/models/pdf_model.dart';
import 'package:csp_dept/screens/PdfPrevviewScreen.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UploadPDFPage extends StatefulWidget {
  const UploadPDFPage({super.key});

  @override
  _UploadPDFPageState createState() => _UploadPDFPageState();
}

class _UploadPDFPageState extends State<UploadPDFPage> {
  Client client = http.Client();
  List<pdfModel> pdfList = [];
  final TextEditingController _textFieldController = TextEditingController();
  List<String> plist = [];
  File? _pdfFile;

  @override
  void initState() {
    super.initState();
    final postModel = Provider.of<DeptDataClass>(context, listen: false);
    postModel.getPostData();
    _retrievePdfs(postModel.post?.name ?? "");
  }

  _retrievePdfs(String id) async {
    pdfList = [];
    List response = jsonDecode((await client.get(showpdfd(id))).body);
    for (var element in response) {
      pdfList.add(pdfModel.fromJson(element));
    }
    plist = pdfList
        .map((pdf) => pdf.name)
        .toSet()
        .toList(); // Get unique departments
    setState(() {});
  }

  Future<void> _selectPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadPdf(String name, String title) async {
    if (_pdfFile == null) {
      // Handle case where no file is selected
      Fluttertoast.showToast(
        msg: 'Please select a pdf',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      uploadpdf,
    );

    request.fields['name'] = name;
    request.fields['title'] = title;

    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'pdf_file',
        _pdfFile!.readAsBytes().asStream(),
        _pdfFile!.lengthSync(),
        filename: _pdfFile!.path.split('/').last,
      ),
    );
    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[300],
            title: const Text('CSP'),
            content: const Text('Successfully uploaded the pdf'),
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
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[300],
            title: const Text('CSP'),
            content: const Text('Failed to upload the pdf'),
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
  }

  Widget _buildListTile(int pdfId, pdfModel pdf) {
    return ListTile(
      title:
          Text(pdf.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      leading: const CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.picture_as_pdf, color: Colors.white),
      ),
      onTap: () {
        _showPdfPreview(pdf);
      },
    );
  }

  void _showPdfPreview(pdfModel pdf) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfPreviewScreen(pdf: pdf),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DeptDataClass>(context, listen: false);
    postModel.getPostData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload PDF'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(labelText: 'Enter PDF Name'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _selectPdf(),
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Select PDF'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _uploadPdf(
                  postModel.post?.name ?? "", _textFieldController.text),
              icon: const Icon(Icons.cloud_upload),
              label: const Text('Upload PDF'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: pdfList.length,
                itemBuilder: (context, index) {
                  return _buildListTile(pdfList[index].id, pdfList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
