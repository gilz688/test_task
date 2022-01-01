import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const BaseContainer({Key? key, required this.title, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).bottomAppBarColor),
            onPressed: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            }),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(child: child),
      ),
    );
  }
}
