import 'dart:ui_web';

import 'package:flutter/widgets.dart';

mixin HistoryBackListener<T extends StatefulWidget> on State<T> {
  final _location = const BrowserPlatformLocation();
  void onHistoryBack(dynamic event) {}

  @override
  void initState() {
    super.initState();
    _location.addPopStateListener((event) async {
      await Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          onHistoryBack(event);
        }
      });
    });
  }

  @override
  void dispose() {
    _location.removePopStateListener(
      (event) {},
    );
    super.dispose();
  }
}
