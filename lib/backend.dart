import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApi {
  final String apiKey;

  NewsApi(this.apiKey);

  Future<List<Map<String, String>>> getTopHeadlines({String? country, String? q}) async {
    String url = 'https://newsapi.org/v2/top-headlines?apiKey=$apiKey';
    if (country != null) {
      url += '&country=$country';
    }
    if (q != null) {
      url += '&q=$q';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> articles = data['articles'];

      return articles.map((article) {
        return {
          'title': article['title'].toString(),
          'description': article['description'].toString(),
          'content': article['content'].toString(),
          'urlToImage': article['urlToImage'].toString(),
        };
      }).toList();
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

}
