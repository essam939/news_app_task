part of 'news_cubit.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}
class NewsPagination extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsResponse> newsResponse;
  NewsLoaded({required this.newsResponse});
  @override
  List<Object> get props => [];
}

class NewsError extends NewsState {
  final ErrorMessageModel errorMessage;

  NewsError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
