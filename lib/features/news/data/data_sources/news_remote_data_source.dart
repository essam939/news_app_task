import 'package:dartz/dartz.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/core/service/remote/dio_consumer.dart';
import 'package:news/features/news/domain/entities/newa_request.dart';
import 'package:news/features/news/domain/entities/news_response.dart';

part 'endpoints.dart';
abstract class BaseNewsDataSource {
  Future<Either<Failure, List<NewsResponse>>> getNews(NewsRequest newsRequest);
}
class NewsDataSource extends BaseNewsDataSource {
  final DioConsumer _dio;
  NewsDataSource(this._dio);
  @override
  Future<Either<Failure, List<NewsResponse>>> getNews(NewsRequest newsRequest) async {
    final responseEither = await _dio.get(
      _NewsEndpoints.news,
      queryParameters: newsRequest.toJson(),
    );
    return responseEither.fold(
          (failure) => Left(failure),
          (response) {
        final categoriesListJson = response["articles"] as List<dynamic>;
        final newsList = categoriesListJson
            .map(
              (categoriesJson) => NewsResponse.fromJson(
              categoriesJson as Map<String, dynamic>),
        )
            .toList();
        return Right(newsList);
      },
    );
  }

}