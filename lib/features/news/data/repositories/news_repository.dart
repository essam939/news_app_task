import 'package:dartz/dartz.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/features/news/data/data_sources/news_remote_data_source.dart';
import 'package:news/features/news/domain/entities/newa_request.dart';
import 'package:news/features/news/domain/entities/news_response.dart';

import '../../domain/repositories/base_news_repository.dart';

class NewsRepository extends BaseNewsRepository {
  final BaseNewsDataSource newsDataSource;

  NewsRepository({required this.newsDataSource});

  @override
  Future<Either<Failure, List<NewsResponse>>> getNews(NewsRequest newsRequest) async {
    return await newsDataSource.getNews(newsRequest);
  }
}
