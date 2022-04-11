import 'package:dynatrace_test/ui/components/spinner_dialog.dart';
import 'package:flutter/material.dart';

mixin LoadingManager {
  void handleLoading(BuildContext context, Stream<bool> stream) {
    stream.listen((isLoading) async {
      if (isLoading == true) {
        await showLoading(context);
      } else if (isLoading == false) {
        hideLoading(context);
      }
    });
  }
}
