import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/features/news/domain/entities/news_response.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget {
  final NewsResponse newsResponse;

   NewsDetailsScreen({super.key, required this.newsResponse});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('News Details'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
                children: [
                  Hero(tag: newsResponse.title,
                      child: Image.network(newsResponse.urlToImage)),
                  Text(newsResponse.title, style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),),
                  Text(newsResponse.author, style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),),
                  Text(newsResponse.publishedAt, style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),),
                  Text(newsResponse.description ?? "", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),),
                  OutlinedButton(onPressed: () {
                    _launchUrl(newsResponse.url);
                  },
                    child: Text("article Website", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),),)
                ]
            )
        )
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
