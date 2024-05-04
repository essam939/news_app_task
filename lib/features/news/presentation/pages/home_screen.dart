import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/news/domain/entities/newa_request.dart';
import 'package:news/features/news/presentation/controller/categories/categories_cubit.dart';
import 'package:news/features/news/presentation/controller/news/news_cubit.dart';
import 'package:news/features/news/presentation/widgets/home_screen/categories_data.dart';
import 'package:news/features/news/presentation/widgets/home_screen/categories_widget.dart';
import 'package:news/features/news/presentation/widgets/home_screen/news_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().getCategories(NewsRequest(page: 1));
    context.read<SelectedCategoryCubit>().setCategory(categoriesList.first.id);
  }

  @override
  void dispose() {
    context.read<NewsCubit>().close();
    context.read<SelectedCategoryCubit>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const CategoriesWidget(),
          NewsListWidget(),
        ],
      ),
    );
  }
}
