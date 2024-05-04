import 'package:flutter_test/flutter_test.dart';
import 'package:news/features/news/presentation/controller/categories/categories_cubit.dart';

void main() {
  group('SelectedCategoryCubit', () {
    test('initial state is 0', () {
      final cubit = SelectedCategoryCubit();
      expect(cubit.state.categoryId, 0);
    });
  });
}