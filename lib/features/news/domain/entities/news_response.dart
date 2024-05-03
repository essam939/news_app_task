
class NewsResponse {
  final Source source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String? content;

  NewsResponse({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    required  this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      source: Source.fromJson(json['source'] as Map<String, dynamic>),
      author: json['author'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] ?? 'https://cdn2.iconfinder.com/data/icons/vivid/48/image-512.png',
      publishedAt: json['publishedAt'] as String,
      content: json['content'] as String?,
    );
  }
}

class Source {
  final String? id;
  final String name;

  Source({
    this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] as String?,
      name: json['name'] as String,
    );
  }
}
