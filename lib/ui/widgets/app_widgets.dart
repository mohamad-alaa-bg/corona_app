import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildLoadingUi() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildErrorUi(String message) {
  return Center(
    child: Text(
      message,
      style: TextStyle(color: Colors.red),
    ),
  );
}
