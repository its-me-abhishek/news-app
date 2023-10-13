import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApi {
  final String apiKey; // Your News API key

  NewsApi(this.apiKey);

  Future<List<Map<String, String>>> getTopHeadlines() async {
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> articles = data['articles'];

      return articles.map((article) {
        return {
          'title': article['title'].toString(),
          'description': article['description'].toString(),
          'content': article['content'].toString(),
        };
      }).toList();
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
