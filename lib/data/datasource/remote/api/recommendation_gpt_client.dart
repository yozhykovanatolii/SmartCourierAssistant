import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_courier_assistant/data/model/route_analysis_model.dart';
import 'package:http/http.dart' as http;

class RecommendationGptClient {
  final String _apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
  final _endpoint = 'https://api.openai.com/v1/chat/completions';

  Future<String?> getRouteRecommendation(
    RouteAnalysisModel analysis,
  ) async {
    final riskyOrders = analysis.riskyOrders;
    if (riskyOrders.isEmpty || riskyOrders.length == 1 || _apiKey.isEmpty) {
      return null;
    }
    final userPrompt = analysis.generateUserPrompt();
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode(
        {
          "model": "gpt-5-nano",
          "messages": [
            {
              "role": "system",
              "content": """
You are a delivery assistant in a courier app.

Task:
Generate one concise route recommendation block for the courier based on risky or delayed deliveries. 
Do not include On time orders. Only suggest actions to avoid or reduce delays.

Rules:
- Maximum 3 sentences
- Be practical and actionable
- Focus on which deliveries to prioritize or monitor
- Use only the delivery address and position in the route to identify orders; do not use order IDs
- Do not explain calculations or reasoning
- Do not include motivational phrases
- Courier makes the final decision
""",
            },
            {"role": "user", "content": userPrompt},
          ],
        },
      ),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final text = data['choices'][0]['message']['content'].toString().trim();
      return text;
    } else {
      print('OpenAI API error: ${response.body}');
      return null;
    }
  }
}
