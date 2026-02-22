import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfPage1 extends StatefulWidget {
  PdfPage1({
    super.key,
    required this.lesson_number,
    required this.pdf_link,
    required this.quize_page,
  });

  String pdf_link;
  int lesson_number;
  Widget quize_page;

  @override
  State<PdfPage1> createState() => _PdfPage1State();
}

class _PdfPage1State extends State<PdfPage1> {
  String? pdfUrl; // To store the selected PDF URL
  bool isDownloading = false; // For download status
  double progress = 0.0; // To track download progress (0 to 1)

  Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.grey.shade300;
  }

  Future<void> pickPdfUrl() async {
    // Simulate URL picking (replace this with actual logic to get the URL)
    setState(() {
      pdfUrl = widget.pdf_link;
    });
  }

  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      print("Permission granted");
    } else if (status.isDenied) {
      print("Permission denied");
    } else if (status.isPermanentlyDenied) {
      // Open app settings to allow the user to grant permissions manually
      openAppSettings();
    }
  }

  Future<void> downloadPdf() async {
    await requestPermission();

    if (pdfUrl == null) return;

    // Request storage permission
    PermissionStatus status = await Permission.storage.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      // Handle permission denied logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Storage permission is required to download the PDF."),
        ),
      );
      return;
    }

    try {
      String? savePath = await FilePicker.platform.saveFile(
        dialogTitle: "Select location to save the PDF",
        fileName:
            "cpp lesson ${widget.lesson_number}}.pdf", // Default file name
      );

      if (savePath == null) {
        return;
      }

      setState(() {
        isDownloading = true;
        progress = 0.0; // Reset progress
      });

      Dio dio = Dio();
      await dio.download(
        pdfUrl!,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              progress = received / total;
            });
          }
        },
      );

      setState(() {
        isDownloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("PDF downloaded to: $savePath"),
        ),
      );
    } catch (e) {
      setState(() {
        isDownloading = false;
        progress = 0.0; // Reset progress on failure
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to download PDF: $e"),
        ),
      );
    }
  }

  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Viewer"),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_circle_right),
            onPressed: () {
              Get.to(() => widget.quize_page,
                  transition: Transition.rightToLeft);
            }, // Trigger URL selection
          ),
        ],
      ),
      body: Column(
        children: [
          if (isDownloading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  LinearProgressIndicator(value: progress),
                  const SizedBox(height: 8),
                  Text("${(progress * 100).toStringAsFixed(1)}% downloaded"),
                ],
              ),
            ),
          Expanded(
            child: pdfUrl == null
                ? Center(
                    child: GestureDetector(
                    onTap: pickPdfUrl,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: getTextColor(context),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text("Open PDF"),
                    ),
                  ))
                : SfPdfViewer.network(
                    pdfUrl!, // Load the selected PDF from the URL
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: downloadPdf, // Trigger PDF download
        child: isDownloading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(Icons.download),
      ),
    );
  }
}
