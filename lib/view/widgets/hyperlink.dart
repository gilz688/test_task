import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Hyperlink extends StatelessWidget {
  final String label;
  final String url;

  const Hyperlink({Key? key, required this.label, required this.url})
      : super(key: key);

  void _launchURL(url) async {
    if (!await launch(url)) throw 'Could not open $url';
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _launchURL(url);
      },
      child: Text(
        label,
        style: const TextStyle(decoration: TextDecoration.underline),
      ),
    );
  }
}
