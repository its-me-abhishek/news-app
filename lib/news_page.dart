import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  final Map<String, String> newsData;

  NewsDetailPage({required this.newsData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (newsData['urlToImage'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  newsData['urlToImage']!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 20),
            Text(
              '${newsData['title']}',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '${newsData['description']}',
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
            ),
            SizedBox(height: 20),
            Text(
              '${newsData['content']}',
              style: TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
