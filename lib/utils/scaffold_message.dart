import 'package:flutter/material.dart';

void showErrorMessage(context, String errmessage) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(errmessage)));
}
