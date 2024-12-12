import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ToastAlert {
  void showLoadingAlert(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Mendeteksi usia Anda',
    );
  }

  void showCompleteAlert(BuildContext context, String title, String text) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: title,
      text: text,
    );
  }
}
