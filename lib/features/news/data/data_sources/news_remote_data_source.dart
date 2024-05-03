import 'package:dartz/dartz.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/core/service/remote/dio_consumer.dart';
import 'package:news/features/news/domain/entities/news_response.dart';

part 'endpoints.dart';
abstract class BaseNewsDataSource {
  Future<Either<Failure, List<NewsResponse>>> getNews();
}
class NewsDataSource extends BaseNewsDataSource {
  final DioConsumer _dio;
  NewsDataSource(this._dio);
  @override
  Future<Either<Failure, List<NewsResponse>>> getNews() async {
    final responseEither = await _dio.get(
      _NewsEndpoints.news,
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