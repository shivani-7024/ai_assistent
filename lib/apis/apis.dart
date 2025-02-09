import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import '../Helper/global.dart';

class Apis {
  static Future<String> getAnswer(String question) async {
    try {
      final res = await post(
        Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text": "Give Response in Markdown with clear view for "+question,
                }
              ]
            }
          ]
        }),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        print('res_apis Full Response: $data');

        final String text = data["candidates"]?[0]["content"]?["parts"]?[0]?["text"] ?? "No text found";
        print('res_apis Extracted Text: $text');
        return text;
      } else {
        print('res_apis HTTP Error: ${res.statusCode}, ${res.body}');
      }
    } catch (e) {
      print('res_apis Exception: $e');
      return 'Something went wrong (Try again in sometime';
    }
    return "";
  }
}
