import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/news/domain/entities/newa_request.dart';
import 'package:news/features/news/presentation/controller/categories/categories_cubit.dart';
import 'package:news/features/news/presentation/controller/news/news_cubit.dart';
import 'package:news/features/news/presentation/widgets/categories_data.dart';
import 'package:news/features/news/presentation/widgets/category_item.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categoriesList
            .map(
              (category) => CategoryItem(
            categoryItem: category,
            isSelected:
            context.watch<SelectedCategoryCubit>().state.categoryId ==
                category.id,
            onTap: () {
              context
                  .read<SelectedCategoryCubit>()
                  .setCategory(category.id);
              context.read<NewsCubit>().getCategories(
                  NewsRequest(page: 1, category: category.name));
            },
          ),
        )
            .toList(),
      ),
    );
  }
}