import 'package:flutter/material.dart';

class LoadingDialog {
  static bool _disablingScreen = false;
  static void disableScreen(BuildContext context, {Duration? timeout}) {
    if (_disablingScreen) return;
    _disablingScreen = true;
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: SizedBox(
            height: 48,
            width: 48,
            child: CircularProgressIndicator(
              color: Colors.blue,
              backgroundColor: Colors.grey.shade200,
              strokeCap: StrokeCap.round,
              strokeWidth: 6.0,
            ),
          ),
        ),
      ),
    );
    if (timeout != null) {
      Future.delayed(timeout, () {
        enableScreen(context);
      });
    }
  }

  static void enableScreen(BuildContext context) {
    if (_disablingScreen) Navigator.of(context).pop();
    _disablingScreen = false;
  }
}
