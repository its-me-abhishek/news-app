import 'package:flutter/material.dart';
import 'package:news/search.dart';
import 'backend.dart';
import 'news_page.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final NewsApi newsApi = NewsApi('ed6340c9d0984bc6abaca8cb751fe2dc');
  late Future<List<Map<String, String>>> headlines;
  String selectedCountry = 'in'; // DEFAULT COUNTRY

  @override
  void initState() {
    super.initState();
    headlines = newsApi.getTopHeadlines(country: selectedCountry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        centerTitle: true,
        title: Text(
          'News App',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            },
          ),
        ],
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
                    title: Text(
                      newsHeadlines[index]['title'] ?? '',
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      newsHeadlines[index]['description'] ?? '',
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewsDetailPage(newsData: newsHeadlines[index]),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Select Country'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _updateCountry('in');
                      Navigator.pop(context);
                    },
                    child: Text('India'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _updateCountry('us');
                      Navigator.pop(context);
                    },
                    child: Text('United States'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _updateCountry('sg');
                      Navigator.pop(context);
                    },
                    child: Text('Singapore'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _updateCountry('ar');
                      Navigator.pop(context);
                    },
                    child: Text('Argentina'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _updateCountry('gr');
                      Navigator.pop(context);
                    },
                    child: Text('Greece'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _updateCountry('nl');
                      Navigator.pop(context);
                    },
                    child: Text('Netherlands'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _updateCountry('za');
                      Navigator.pop(context);
                    },
                    child: Text('South Africe'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _updateCountry('Au');
                      Navigator.pop(context);
                    },
                    child: Text('Australia'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _updateCountry('at');
                      Navigator.pop(context);
                    },
                    child: Text('Austria'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _updateCountry('be');
                      Navigator.pop(context);
                    },
                    child: Text('Belgium'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _updateCountry('br');
                      Navigator.pop(context);
                    },
                    child: Text('Brazil'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _updateCountry('ca');
                      Navigator.pop(context);
                    },
                    child: Text('Canada'),
                  ),
                ],
              ),
            ),
          );
        },
        child: Icon(Icons.location_on),
      ),
    );
  }

void _updateCountry(String newCountry) {
    setState(() {
      selectedCountry = newCountry;
      headlines = newsApi.getTopHeadlines(country: selectedCountry);
    });
  }
}
