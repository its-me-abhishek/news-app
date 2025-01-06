import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApi {
  final String apiKey;

  NewsApi(this.apiKey);

  Future<List<Map<String, String>>> getTopHeadlines(
      {String? country, String? q}) async {
    String url = 'https://newsapi.org/v2/top-headlines?language=en';
    if (country != null) {
      url += '&q=$country+news';
    }
    if (q != null) {
      url += '&q=$q';
    }
    url += '&apiKey=$apiKey';
    print(url);

    final response = await http.get(Uri.parse(url));
    print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> articles = data['articles'];

      return articles.map((article) {
        return {
          'title': article['title'].toString(),
          'description': article['description'].toString(),
          'content': article['content'].toString(),
          'category': article['category'].toString(),
          'urlToImage': article['urlToImage'].toString(),
        };
      }).toList();
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
