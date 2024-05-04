import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/core/service/remote/error_message_remote.dart';
import 'package:news/core/utilities/base_usecase.dart';
import 'package:news/features/news/domain/entities/newa_request.dart';
import 'package:news/features/news/domain/entities/news_response.dart';
import 'package:news/features/news/domain/use_cases/get_news_usecase.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final GetNewsUseCase getNewsUseCase;
  NewsCubit({required this.getNewsUseCase}) : super(NewsInitial());
  Future<void> getCategories(NewsRequest newsRequest) async {
    emit(NewsLoading());
    final result = await getNewsUseCase.execute(newsRequest);
    result.fold(
            (failure) => emit(NewsError(errorMessage: failure.errorMessageModel)),
            (response) => emit(NewsLoaded( newsResponse: response)));
  }
}
