import 'dart:io';

import 'package:csp_citizen/models/pdf_model.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfPreviewScreen extends StatefulWidget {
  final pdfModel pdf;

  const PdfPreviewScreen({super.key, required this.pdf});

  @override
  State<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  late Future<File> _downloadFuture;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _downloadFuture = _downloadPdf();
  }

  Future<File> _downloadPdf() async {
    final url = showbu(widget.pdf.pdf_file);
    final filename = '${widget.pdf.title}.pdf';
    final downloadsPath = Directory.systemTemp.path;
    final file = File('$downloadsPath/$filename');

    final response = await HttpClient().getUrl(Uri.parse(url));
    final downloadedFile = await response.close();

    await file
        .writeAsBytes(await downloadedFile.expand((bytes) => bytes).toList());

    setState(() {
      _loading = false;
    });

    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder<File>(
              future: _downloadFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error loading PDF: ${snapshot.error}'),
                    );
                  }
                  final file = snapshot.data!;
                  return PDFView(
                    filePath: file.path,
                    onError: (error) {
                      Center(
                        child: Text('Error loading PDF: $error'),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
    );
  }
}
