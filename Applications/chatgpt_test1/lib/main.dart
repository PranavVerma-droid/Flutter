import 'package:flutter/material.dart';
import 'chatgpt.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String _response = "";

  void _getChatResponse(String text) async {
    var response = await ChatGPT.getResponse(text);
    setState(() {
      _response = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            onSubmitted: _getChatResponse,
          ),
          SizedBox(height: 16),
          Text(_response),
        ],
      ),
    );
  }
}
