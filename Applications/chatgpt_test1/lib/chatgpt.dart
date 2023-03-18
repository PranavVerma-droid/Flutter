import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPT {
  static const String API_URL = "https://api.openai.com/v1/engine/davinci-codex/completions";

  static Future<String> getResponse(String text) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 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',
    };

    var body = json.encode({
      'prompt': text,
      'max_tokens': 150,
      'temperature': 0.5,
    });

    var response = await http.post(Uri.parse(API_URL), headers: headers, body: body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var choices = data['choices'];
      var text = choices[0]['text'];
      return text.toString();
    } else {
      throw Exception('Failed to load response');
    }
  }
}
