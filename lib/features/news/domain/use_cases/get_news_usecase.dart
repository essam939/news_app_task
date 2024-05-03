import 'package:dartz/dartz.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/core/utilities/base_usecase.dart';
import 'package:news/features/news/domain/entities/news_response.dart';
import 'package:news/features/news/domain/repositories/base_news_repository.dart';

class GetNewsUseCase extends BaseUseCase<List<NewsResponse>, NoParams > {
  final BaseNewsRepository newsRepository;

  GetNewsUseCase(this.newsRepository);

  @override
  Future<Either<Failure, List<NewsResponse>>> execute(NoParams params) async {
    return await newsRepository.getNews();
  }
}