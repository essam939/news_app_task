part of 'categories_cubit.dart';

// Define the events
abstract class SelectedCategoryEvent {}

class SetCategory extends SelectedCategoryEvent {
  final int categoryId;
  SetCategory(this.categoryId);
}

// Define the state
class SelectedCategoryState {
  final int categoryId;
  SelectedCategoryState(this.categoryId);
}
