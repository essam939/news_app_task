import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/news/domain/entities/newa_request.dart';
import 'package:news/features/news/presentation/controller/categories/categories_cubit.dart';
import 'package:news/features/news/presentation/controller/news/news_cubit.dart';
import 'package:news/features/news/presentation/widgets/categories_data.dart';
import 'package:news/features/news/presentation/widgets/product_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsListWidget extends StatelessWidget {
  final _refreshController = RefreshController(initialRefresh: false);

  NewsListWidget({super.key});

  void _onRefresh(BuildContext context) async {
    context.read<NewsCubit>().getCategories(NewsRequest(page: 1));
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading(BuildContext context) async {
    context.read<NewsCubit>().getCategories(NewsRequest(
        page: ++context.read<NewsCubit>().page,
        category: categoriesList
            .firstWhere((element) =>
        element.id ==
            context.read<SelectedCategoryCubit>().state.categoryId)
            .name));
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NewsLoaded || state is NewsPagination) {
          final news = context.select((NewsCubit cubit) => cubit.newsList);
          return Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: _refreshController,
              onLoading: () => _onLoading(context),
              onRefresh: () => _onRefresh(context),
              child: ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  final newsData = news[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ProductItem(newsDetails: newsData),
                  );
                },
              ),
            ),
          );
        } else if (state is NewsError) {
          return Center(
            child: Text(state.errorMessage.msg),
          );
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}