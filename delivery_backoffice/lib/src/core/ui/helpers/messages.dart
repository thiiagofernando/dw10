import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

mixin Messages<T extends StatefulWidget> on State<T> {
  void showError(String menssage) {
    _showSnackBar(
      AwesomeSnackbarContent(
        title: 'Erro',
        message: menssage,
        contentType: ContentType.failure,
      ),
    );
  }

  void showWarning(String menssage) {
    _showSnackBar(
      AwesomeSnackbarContent(
        title: 'Atenção',
        message: menssage,
        contentType: ContentType.warning,
      ),
    );
  }

  void showInfo(String menssage) {
    _showSnackBar(
      AwesomeSnackbarContent(
        title: 'Atenção',
        message: menssage,
        contentType: ContentType.help,
      ),
    );
  }

  void showSuccess(String menssage) {
    _showSnackBar(
      AwesomeSnackbarContent(
        title: 'Sucesso',
        message: menssage,
        contentType: ContentType.success,
      ),
    );
  }

  void _showSnackBar(AwesomeSnackbarContent content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.only(top: 72),
        backgroundColor: Colors.transparent,
        content: content,
      ),
    );
  }
}
