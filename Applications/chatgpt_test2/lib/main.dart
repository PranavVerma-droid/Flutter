import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _textEditingController = TextEditingController();
  String _response = '';

  Future<String> _generateResponse(String prompt) async {
    const String endpoint =
        'https://api.openai.com/v1/engines/davinci-codex/completions';
    const String apiKey = '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';

    final response = await http.post(Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'prompt': prompt,
          'max_tokens': 150,
          'temperature': 0.5,
        }));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['choices'][0]['text'];
      return data;
    } else {
      throw Exception('Failed to generate response');
    }
  }

  void _handleSubmitted(String text) async {
    _textEditingController.clear();
    final response = await _generateResponse(text);
    setState(() {
      _response = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ChatGPT Demo'),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                reverse: true,
                itemCount: 1,
                itemBuilder: (_, int index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      _response,
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            ),
            Divider(height: 1),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Send a message'),
                      onSubmitted: _handleSubmitted,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _handleSubmitted(_textEditingController.text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
