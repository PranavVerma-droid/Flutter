import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_processing/flutter_processing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Python Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Python Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  Future<void> _analyzeText() async {
    final process = await Process.start(
      'python',
      ['sentiment_analysis.py', _controller.text],
    );

    final output = await process.stdout.transform(utf8.decoder).toList();
    final error = await process.stderr.transform(utf8.decoder).toList();

    setState(() {
      _result = error.isNotEmpty ? error.join('\n') : output.join('\n');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter some text',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _analyzeText,
              child: Text('Analyze Text'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_result),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
