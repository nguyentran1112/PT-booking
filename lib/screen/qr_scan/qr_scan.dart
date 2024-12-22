import 'package:flutter/material.dart';
import 'package:flutter_web_qrcode_scanner/flutter_web_qrcode_scanner.dart';

class QrScannerWidget extends StatefulWidget {
  const QrScannerWidget({super.key});

  @override
  State<QrScannerWidget> createState() => _QrScannerWidgetState();
}

class _QrScannerWidgetState extends State<QrScannerWidget> {
  String? _data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _data == null
            ? Container()
            : Center(
                child: Text(
                  _data!,
                  style: const TextStyle(fontSize: 18, color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              ),
        FlutterWebQrcodeScanner(
          cameraDirection: CameraDirection.back,
          onGetResult: (result) {
            setState(() {
              _data = result;
            });
          },
          stopOnFirstResult: true,
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          onError: (error) {
            // Handle error if necessary
          },
          onPermissionDeniedError: () {
            // Show an alert dialog or handle permission error
          },
        ),
      ],
    );
  }
}
