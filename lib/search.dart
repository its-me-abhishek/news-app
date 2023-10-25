import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'backend.dart';
import 'news_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        centerTitle: true,
        title: const Text(
          'News Search',
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.w600,
            height: 0.05,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              cursorWidth: 0,
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                hintText: '     Search News...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _performSearch();
                  },
                ),
              ),
              onSubmitted: (query) {
                _performSearch();
              },
            ),
          ),
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Text('No results found'),
      );
    } else {
      return ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final newsData = _searchResults[index];
          return ListTile(
            title: Text(newsData['title'] ?? ''),
            subtitle: Text(newsData['description'] ?? ''),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(newsData: newsData),
                ),
              );
            },
          );
        },
      );
    }
  }

  void _performSearch() async {
    final String query = _searchController.text.trim();
    if (query.isNotEmpty) {
      try {
        final NewsApi newsApi = NewsApi(
            'ed6340c9d0984bc6abaca8cb751fe2dc');
        final List<Map<String, String>> results =
            await newsApi.getTopHeadlines(q: query);
        setState(() {
          _searchResults = results
              .where((news) =>
                  news['title']!.toLowerCase().contains(query.toLowerCase()) ||
                  news['description']!
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .toList();
        });
      } catch (e) {
        print('Error: $e');
      }
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }
}
