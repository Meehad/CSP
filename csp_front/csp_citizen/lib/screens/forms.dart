import 'dart:convert';
import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:csp_citizen/models/pdf_data.dart';
import 'package:csp_citizen/models/pdf_model.dart';
import 'package:csp_citizen/screens/pdfpreview.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Formspage extends StatefulWidget {
  const Formspage({super.key});

  @override
  State<Formspage> createState() => _FormsPageState();
}

class _FormsPageState extends State<Formspage> {
  Client client = http.Client();
  List<pdfModel> pdfList = [];

  @override
  void initState() {
    _retrievePdfs();
    super.initState();
    final postpdf = Provider.of<pdfClass>(context, listen: false);
    postpdf.getPostData();
  }

  _retrievePdfs() async {
    pdfList = [];
    List response = jsonDecode((await client.get(showPdf)).body);
    for (var element in response) {
      pdfList.add(pdfModel.fromJson(element));
    }
    setState(() {});
  }

  _downloadclicked(int pdfId, String title) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text('Are you sure you want to download $title PDF?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                // Proceed with the download
                try {
                  final response = await http.get(downloadpdf(pdfId));
                  var downloadsPath = await AndroidPathProvider.downloadsPath;

                  if (response.statusCode == 200) {
                    String filePath = '$downloadsPath/$title.pdf';
                    File file = File(filePath);
                    await file.writeAsBytes(response.bodyBytes);

                    Fluttertoast.showToast(
                      msg: 'Successfully downloaded PDF',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  } else {
                    // Handle errors, e.g., print an error message
                    Fluttertoast.showToast(
                      msg:
                          'Failed to download PDF. Status code: ${response.statusCode}',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                } catch (e) {
                  // Handle exceptions, e.g., print an error message
                  Fluttertoast.showToast(
                    msg: 'Error during PDF download: $e',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                }
              },
              child: const Text('Download'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildListTile(int pdfId, pdfModel pdf) {
    return ListTile(
      title:
          Text(pdf.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      leading: const CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.picture_as_pdf, color: Colors.white),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.file_download),
        onPressed: () => _downloadclicked(pdfId, pdf.title),
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
        builder: (context) =>
            PdfPreviewScreen(pdfUrl:'http://10.0.2.2:8000${pdf.pdf_file}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forms'),
      ),
      body: ListView.builder(
        itemCount: pdfList.length,
        itemBuilder: (context, index) {
          return _buildListTile(pdfList[index].id, pdfList[index]);
        },
      ),
    );
  }
}
