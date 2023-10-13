import 'package:flutter/material.dart';
import 'news_page.dart';
import 'backend.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NewsApi newsApi = NewsApi('ed6340c9d0984bc6abaca8cb751fe2dc');
  late Future<List<Map<String, String>>> headlines;

  @override
  void initState() {
    super.initState();
    headlines = newsApi.getTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: headlines,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Map<String, String>> newsHeadlines = snapshot.data ?? [];
            return ListView.builder(
              itemCount: newsHeadlines.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(newsHeadlines[index]['title'] ?? ''),
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailPage(newsData: newsHeadlines[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
