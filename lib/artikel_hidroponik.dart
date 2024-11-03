import 'package:flutter/material.dart';
import 'package:tubes_papb/detail_artikel_hidroponik.dart';
import 'create_article_page.dart';

class HydroponicsDetailsPage extends StatefulWidget {
  const HydroponicsDetailsPage({super.key});

  @override
  _HydroponicsDetailsPageState createState() => _HydroponicsDetailsPageState();
}

class _HydroponicsDetailsPageState extends State<HydroponicsDetailsPage> {
  List<Map<String, String>> articles = [];

  void _addArticle(Map<String, String> article) {
    setState(() {
      articles.add(article);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        title: const Text("Hidroponik", style: TextStyle(color: Colors.black)),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('images/hidroponiksederhana.jpeg'), // Gambar profil default
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article['author'] ?? 'Penulis tidak ada',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            article['institution'] ?? 'Institusi tidak ada',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article['title'] ?? 'Judul tidak ada',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article['content'] ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleDetailPage(
                              title: article['title'] ?? '',
                              imagePath: 'images/hidroponiksederhana.jpeg', // Path gambar
                              description: article['content'] ?? '',
                            ),
                          ),
                        );
                      },
                      child: const Text("Selengkapnya"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _buildAddArticleSection(),
    );
  }

  Widget _buildAddArticleSection() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateArticlePage()),
        ).then((newArticle) {
          if (newArticle != null) {
            _addArticle(newArticle); // Menambahkan artikel baru jika ada
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      child: const Text("Tulis Artikel"),
    );
  }
}