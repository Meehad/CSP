import 'dart:convert';
import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:csp_citizen/models/pdf_model.dart';
import 'package:csp_citizen/screens/pdfpreview.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  List<pdfModel> filteredPdfList = [];
  List<String> departments = [];
  String selectedDepartment = 'All';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _retrievePdfs();
    super.initState();
  }

  _retrievePdfs() async {
    pdfList = [];
    List response = jsonDecode((await client.get(showPdf)).body);
    for (var element in response) {
      pdfList.add(pdfModel.fromJson(element));
    }
    departments = pdfList
        .map((pdf) => pdf.name)
        .toSet()
        .toList(); // Get unique departments
    setState(() {});
  }

  void filterPdfList(String query) {
    if (query.isNotEmpty) {
      List<pdfModel> filteredList = [];
      for (var pdf in pdfList) {
        if (pdf.title.toLowerCase().contains(query.toLowerCase())) {
          filteredList.add(pdf);
        }
      }
      setState(() {
        filteredPdfList = filteredList;
      });
    } else {
      setState(() {
        filteredPdfList = List.from(pdfList);
      });
    }
  }

  filterPdfListdept(String selectedDepartment) {
    if (selectedDepartment != 'All') {
      List<pdfModel> filteredList = [];
      for (var pdf in pdfList) {
        if (pdf.name.toLowerCase().contains(selectedDepartment.toLowerCase())) {
          filteredList.add(pdf);
        }
      }
      setState(() {
        filteredPdfList = filteredList;
      });
    } else {
      setState(() {
        filteredPdfList = List.from(pdfList);
      });
    }
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
        builder: (context) => PdfPreviewScreen(pdf: pdf),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forms'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: searchController,
                  onChanged: (value) {
                    filterPdfList(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Search PDFs',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10), // Add some spacing
                Center(
                  child: DropdownMenu(
                    label: const Text('Select Department'),
                    helperText: 'Filter forms by department',
                    width: 395,
                    leadingIcon: const Icon(Icons.menu),
                    dropdownMenuEntries: [
                      const DropdownMenuEntry(
                        value: 'All',
                        label: 'All Departments',
                      ),
                      for (String department in departments)
                        DropdownMenuEntry(
                          value: department,
                          label: department,
                        ),
                    ],
                    onSelected: (value) {
                      setState(() {
                        selectedDepartment = value.toString();
                        filterPdfListdept(
                            selectedDepartment); // Apply filtering
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPdfList.length,
              itemBuilder: (context, index) {
                return _buildListTile(
                    filteredPdfList[index].id, filteredPdfList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
