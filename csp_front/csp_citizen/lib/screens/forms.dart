import 'package:flutter/material.dart';

class Formspage extends StatefulWidget {
  const Formspage({super.key});

  @override
  State<Formspage> createState() => _FormsPageState();
}

 class _FormsPageState extends State<Formspage> {
  final List<String> pdfList = ['PDF 1', 'PDF 2', 'PDF 3', 'PDF 4']; // Add your PDF names here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF698996),
        title: const Text('Forms'),
      ),
      body: ListView.builder(
        itemCount: pdfList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pdfList[index]),
            trailing: IconButton(
              icon: const Icon(Icons.file_download),
              onPressed: () {
                // Add your PDF download logic here
                // For example, you can use a package like `url_launcher` to open the PDF link
                // or use `http` package to download the PDF locally.
                // Make sure to handle the download logic based on your requirements.
                // You may want to show a progress indicator during the download process.
                // For simplicity, this example does not include the actual download implementation.
                // You can customize it based on your needs.
                // Here's a basic example using `url_launcher`:
                // launch('https://example.com/${pdfList[index]}.pdf');
              },
            ),
          );
        },
      ),
    );
  }
}

