import 'package:flutter/material.dart';
import 'package:news/features/news/domain/entities/news_response.dart';
import 'package:news/features/news/presentation/pages/news_details.dart';

class ProductItem extends StatelessWidget {
  final NewsResponse newsDetails;

  const ProductItem({
    super.key,
    required this.newsDetails,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetailsScreen(context),
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildImageSection(),
            _buildDetailsSection(),
          ],
        ),
      ),
    );
  }

  void _navigateToDetailsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailsScreen(
          newsResponse: newsDetails,
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      width: 100,
      height: 100,
      child: Hero(
        tag: newsDetails.title,
        child: Image.network(
          newsDetails.urlToImage,
        ),
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(),
            const SizedBox(height: 8),
            _buildAuthor(),
            const SizedBox(height: 8),
            _buildSource(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      newsDetails.title,
      maxLines: 1,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }

  Widget _buildAuthor() {
    return Text(
      newsDetails.author,
      style: const TextStyle(fontSize: 16, color: Colors.black),
    );
  }

  Widget _buildSource() {
    return Text(
      newsDetails.source.name,
      style: const TextStyle(fontSize: 16, color: Colors.black),
    );
  }
}