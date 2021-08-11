import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesystem/controllers/theme_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// Represents Homepage for Navigation
class PDFViewerWidget extends StatefulWidget {
  @override
  _PDFViewerWidget createState() => _PDFViewerWidget();
}

class _PDFViewerWidget extends State<PDFViewerWidget> {
  ThemeController tc = Get.put(ThemeController());
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController _pdfController;

  bool _canShowPdf;
  String _error;

  @override
  void initState() {
    super.initState();
    _canShowPdf = false;
    _pdfController = PdfViewerController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: tc.isColorChangeWD(),
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: tc.isColorChangeDW(),
        centerTitle: true,
        title: Text('OneSystem > PDFViewer Page',
            style: TextStyle(color: tc.isColorChangeWD(), fontSize: 16)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: tc.isColorChangeWD(),
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.zoom_in,
              color: tc.isColorChangeWD(),
            ),
            onPressed: () {
              _pdfController.zoomLevel = 3;
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: Future.delayed(Duration(microseconds: 1)).then((value) {
            _canShowPdf = true;
          }),
          builder: (context, snapshot) {
            if (_canShowPdf) {
              return Stack(children: [
                SfPdfViewer.asset(
                  'assets/isometric.pdf',
                  key: _pdfViewerKey,
                  controller: _pdfController,
                  onDocumentLoadFailed: (details) {
                    setState(() {
                      _error = details.description;
                    });
                    print(_error);
                  },
                ),
              ]);
            } else {
              return Container();
            }
          }),
    );
  }
}
