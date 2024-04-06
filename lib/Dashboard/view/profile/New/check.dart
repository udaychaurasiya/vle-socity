import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class check extends StatefulWidget {
  const check({Key? key}) : super(key: key);

  @override
  State<check> createState() => _checkState();
}

class _checkState extends State<check> {
  @override
  void _openURLsInText(String text) async {
    final RegExp urlRegex = RegExp(r'http(s)?://\S+');
    final List<Match> matches = urlRegex.allMatches(text).toList();

    for (final match in matches) {
      final String url = match.group(0)!;

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
  Widget build(BuildContext context) {
    String textWithLinks = "my website djgfuiguhgf";
    return Scaffold(
      appBar: AppBar(
        title: Text("djkgyf"),

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textWithLinks,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _openURLsInText(textWithLinks);
                },
                child: Text('Open URLs in Text'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
