import 'package:flutter/material.dart';

class Page2 {

  void loginNavigate(context)
  {
    Navigator.of(context).pushNamed(
      '/second',
      arguments: 'Hello from the first page!',
    );
  }

}

