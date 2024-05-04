import 'package:flutter/material.dart';
import 'package:news/features/news/domain/entities/news_response.dart';

class NewsImage extends StatelessWidget {
  final NewsResponse newsResponse;

  const NewsImage({super.key, required this.newsResponse});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: newsResponse.title,
      child: Image.network(newsResponse.urlToImage),
    );
  }
}