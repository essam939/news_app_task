import 'package:dartz/dartz.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/features/news/domain/entities/newa_request.dart';
import 'package:news/features/news/domain/entities/news_response.dart';

abstract class BaseNewsRepository {
  Future<Either<Failure,List<NewsResponse>>> getNews( NewsRequest newsRequest);
}