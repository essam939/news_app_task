import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_state.dart';

class SelectedCategoryCubit extends Cubit<SelectedCategoryState> {
  SelectedCategoryCubit() : super(SelectedCategoryState(0));

  void setCategory(int categoryId) {
    emit(SelectedCategoryState(categoryId));
  }
}

