import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/service/remote/error_message_remote.dart';
import 'package:news/features/news/domain/entities/newa_request.dart';
import 'package:news/features/news/domain/entities/news_response.dart';
import 'package:news/features/news/domain/use_cases/get_news_usecase.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final GetNewsUseCase getNewsUseCase;
  List<NewsResponse> newsList = [];
  int page = 1;

  NewsCubit({required this.getNewsUseCase}) : super(NewsInitial());

  Future<void> getCategories(NewsRequest newsRequest) async {
    if (newsRequest.page == 1) {
      emit(NewsLoading());
    } else {
      emit(NewsPagination());
    }
    final result = await getNewsUseCase.execute(newsRequest);
    result.fold(
      (failure) => emit(NewsError(errorMessage: failure.errorMessageModel)),
      (response) {
        if (newsRequest.page == 1&& response.isNotEmpty) {
          newsList = response;
        } else {
          newsList.addAll(response);
        }
        emit(NewsLoaded(newsResponse: newsList));
      },
    );
  }
}
