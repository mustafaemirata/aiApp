import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey = 'AIzaSyDYdxHL0VT8jRWiWj3rutxY2SDUqLw1krU';

  Future<String> sendPrompt(String prompt) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey',
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt},
            ],
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'] ?? '';
    } else {
      throw Exception('Failed to get response: ${response.body}');
    }
  }

  Future<String> sendMessage(String content) async {
    // TODO: Implement the API call to send the message and return the response as a String
    // For now, return a dummy response
    await Future.delayed(Duration(seconds: 1));
    return "This is a response from GeminiService for: $content";
  }
}
